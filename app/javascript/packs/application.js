// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import $ from 'jquery'
global.$ = $
global.jQuery = $
import 'bootstrap'
import '../stylesheets/application'
import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import navbar from '../components/layouts/navbar'
import employee from '../components/forms/employee'
import payrollreport from '../components/forms/payrollreport'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '[data-behavior="vue"]', // now we can wrap the entire app in a vue layer rather than mounting components individually
    data: () => {
      return {}
    },
    components: { navbar, employee, payrollreport }
  })
})