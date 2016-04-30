window.xx = (t) -> console.log(t)

Vue = require 'vue'
moment = require 'moment'

Vue.component 'app', require('./components/app.vue')
Vue.filter 'moment', (value) -> moment(value).fromNow()

new Vue
  el: 'body'
