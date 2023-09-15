const admin = require("firebase-admin");
const functions = require("firebase-functions");
const pathString = "users/{uid}/posts/{postId}/postComments/{postCommentId}/" +
  "postCommentReplies/{postCommentReplyId}/postCommentReplyLikes/{activeUid}";
const config = functions.config();
admin.initializeApp(config.firebase);
const batchLimit = 500;
const plusOne = 1;
const minusOne = -1;
const fireStore = admin.firestore();

exports.onFollowerCreate = functions.firestore.
    document("users/{uid}/followers/{followerUid}").onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          await fireStore.collection("users").doc(newValue.followedUid).update({
            "followerCount": admin.firestore.FieldValue.increment(plusOne),
          });
          await fireStore.collection("users").doc(newValue.followerUid).update({
            "followingCount": admin.firestore.FieldValue.increment(plusOne),
          });
        },
    );

exports.onFollowerDelete = functions.firestore.
    document("users/{uid}/followers/{followerUid}").onDelete(
        async (snap, _) => {
          const newValue = snap.data();
          await fireStore.collection("users").doc(newValue.followedUid).update({
            "followerCount": admin.firestore.FieldValue.increment(minusOne),
          });
          await fireStore.collection("users").doc(newValue.followerUid).update({
            "followingCount": admin.firestore.FieldValue.increment(minusOne),
          });
        },
    );

exports.onPostLikeCreate = functions.firestore.
    document("users/{uid}/posts/{postId}/postLikes/{activeUid}").onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          await newValue.postRef.update({
            "likeCount": admin.firestore.FieldValue.increment(plusOne),
          });
        },
    );

exports.onPostLikeDelete = functions.firestore.
    document("users/{uid}/posts/{postId}/postLikes/{activeUid}").onDelete(
        async (snap, _) => {
          const newValue = snap.data();
          await newValue.postRef.update({
            "likeCount": admin.firestore.FieldValue.increment(minusOne),
          });
        },
    );
exports.onPostCommentCreate = functions.firestore.
    document("users/{uid}/posts/{postId}/postComments/{id}").onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          await newValue.postRef.update({
            "postCommentCount": admin.firestore.FieldValue.increment(plusOne),
          });
        },
    );

exports.onPostCommentReplyLikeCreate = functions.firestore
    .document(pathString)
    .onCreate(async (snap, _) => {
      const newValue = snap.data();
      await newValue.postCommentReplyRef.update({
        likeCount: admin.firestore.FieldValue.increment(plusOne),
      });
    });

exports.onPostCommentReplyLikeDelete = functions.firestore
    .document(pathString)
    .onDelete(async (snap, _) => {
      const newValue = snap.data();
      await newValue.postCommentReplyRef.update({
        likeCount: admin.firestore.FieldValue.increment(minusOne),
      });
    });
exports.onPostCommentReplyCreate = functions.firestore
    .document("users/{uid}/posts/{postId}/postComments/{postCommentId}/"+
    "postCommentReplies/{postCommentReplyId}").onCreate(
        async (snap, _) => {
        // コメントのpostCommentReplyCountを増やしたい
          const newValue = snap.data();
          await newValue.postCommentRef.update({
            "postCommentReplyCount":
            admin.firestore.FieldValue.increment(plusOne),
          });
        },
    );
exports.onPostCommentReplyDelete = functions.firestore
    .document("users/{uid}/posts/{postId}/postComments/" +
    "{postCommentId}/postCommentReplies/{postCommentReplyId}").onDelete(
        async (snap, _) => {
        // コメントのpostCommentReplyCountを減らしたい
          const newValue = snap.data();
          await newValue.postCommentRef.update({
            "postCommentReplyCount":
              admin.firestore.FieldValue.increment(minusOne),
          });
        },
    );
exports.onUserUpdateLogCreate = functions.firestore
    .document("users/{uid}/userUpdateLogs/{userUpdateLogId}").onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          const userRef = newValue.userRef;
          const uid = newValue.uid;
          const userName = newValue.userName;
          const userImageURL = newValue.userImageURL;
          const now = admin.firestore.Timestamp.now();
          await userRef.update({
            "userName": userName,
            "userImageURL": userImageURL,
            // updateAtは改竄されないようにcloud functionsで制限する
            "updateAt": now,
          });
          // 複数の投稿をupdateするのでbatchが必要
          const postQshot = await fireStore
              .collection("users").doc(uid).collection("posts").get();
          // 一回のbatchにつき、500回までしか処理できないから
          let postCount = 0;
          let postBatch = fireStore.batch();
          for (const post of postQshot.docs) {
            postBatch.update(post.ref, {
              "userName": userName,
              "userImageURL": userImageURL,
              "updateAt": now,
            }),
            postCount += 1;
            if (postCount == batchLimit) {
              // 500行ったらcommit
              await postBatch.commit();
              // batchを新しく取得
              postBatch = fireStore.batch();
              postCount = 0;
            }
          }
          if (postCount > 0) {
            await postBatch.commit();
          }
          // commentの処理
          // collectionGroupを使用し、fieldで制限する(uidとか)場合は除外が必要
          const commentQshot = await fireStore
              .collectionGroup("postComments").where("uid", "==", uid).get();
          let commentCount = 0;
          let commentBatch = fireStore.batch();
          for (const comment of commentQshot.docs) {
            commentBatch.update(comment.ref, {
              "userName": userName,
              "userImageURL": userImageURL,
              "updateAt": now,
            }),
            commentCount += 1;
            if (commentCount == batchLimit) {
              // 500行ったらcommit
              await commentBatch.commit();
              // batchを新しく取得
              commentBatch = fireStore.batch();
              commentCount = 0;
            }
          }
          if (commentCount > 0) {
            await commentBatch.commit();
          }
          // replyの処理
          const replyQshot = await fireStore.
              collectionGroup("postCommentReplies")
              .where("uid", "==", uid).get();
          let replyCount = 0;
          let replyBatch = fireStore.batch();
          for (const reply of replyQshot.docs) {
            replyBatch.update(reply.ref, {
              "userName": userName,
              "userImageURL": userImageURL,
              "updateAt": now,
            }),
            replyCount += 1;
            if (replyCount == batchLimit) {
              // 500行ったらcommit
              await replyBatch.commit();
              // batchを新しく取得
              replyBatch = fireStore.batch();
              replyCount = 0;
            }
          }
          if (replyCount > 0) {
            await replyBatch.commit();
          }
        },
    );
exports.onUserMutesCreate = functions.firestore.
    document("users/{uid}/userMutes/{activeUid}").onCreate(
        async (snap, _) => {
          const newValue = snap.data();
          await newValue.passiveUserRef.update({
            "muteCount": admin.firestore.FieldValue.increment(plusOne),
          });
        },
    );

exports.onUserMutesDelete = functions.firestore.
    document("users/{uid}/userMutes/{activeUid}").onDelete(
        async (snap, _) => {
          const newValue = snap.data();
          await newValue.passiveUserRef.update({
            "muteCount": admin.firestore.FieldValue.increment(minusOne),
          });
        },
    );
