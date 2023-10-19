switch(document.readyState){
    case 'complete':
      new multi_language()
      break
    default:
      window.addEventListener('load' , (()=>{
        new multi_language()
      }))
  }
  
  function multi_language(){
    this.set_current_lang()
  }
  multi_language.prototype.get_lang_lists = function(){
    return document.querySelectorAll(`input[type='radio'][name='lang']`)
  }
  multi_language.prototype.set_current_lang = function(){
    const current_lang = document.querySelector('html').getAttribute('lang')
    this.checked_lang_list(current_lang)
  }
  multi_language.prototype.checked_lang_list = function(current_lang){
    const elms = this.get_lang_lists()
    for(const elm of elms){
      if(elm.value === current_lang){
        elm.checked = true
      }
      elm.addEventListener('click' , this.click_lang.bind(this))
    }
  }
  multi_language.prototype.click_lang = function(e){
    const lang = e.target.value
    document.querySelector('html').setAttribute('lang' , lang)
  }