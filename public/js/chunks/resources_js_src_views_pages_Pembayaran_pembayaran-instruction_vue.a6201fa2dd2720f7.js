"use strict";
(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Pembayaran_pembayaran-instruction_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=script&lang=js&":
/*!*********************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! axios */ "./node_modules/axios/index.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_0__);
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      paymentInstructions: []
    };
  },
  mounted: function mounted() {
    var _this = this;

    var access_token = localStorage.getItem('access_token');
    var url = this.$route.query.howToPayApi;
    axios__WEBPACK_IMPORTED_MODULE_0___default().get(url, {
      headers: {
        'Authorization': "Bearer ".concat(access_token)
      }
    }).then(function (response) {
      _this.paymentInstructions = response.data; // console.log(this.schedule);
    })["catch"](function (error) {
      console.log(error);
    });
  }
});

/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=script&lang=js&":
/*!*****************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pembayaran-instruction.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=template&id=b9422a2a&":
/*!***********************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=template&id=b9422a2a& ***!
  \***********************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_vue_vue_type_template_id_b9422a2a___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_vue_vue_type_template_id_b9422a2a___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_vue_vue_type_template_id_b9422a2a___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pembayaran-instruction.vue?vue&type=template&id=b9422a2a& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=template&id=b9422a2a&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=template&id=b9422a2a&":
/*!**************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=template&id=b9422a2a& ***!
  \**************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* binding */ render; },
/* harmony export */   "staticRenderFns": function() { return /* binding */ staticRenderFns; }
/* harmony export */ });
var render = function () {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c(
    "div",
    [
      _c("h2", [_vm._v("How to Pay")]),
      _vm._v(" "),
      _vm._l(
        _vm.paymentInstructions.payment_instruction,
        function (instruction) {
          return _c("div", { key: instruction.channel }, [
            _c("h3", [_vm._v(_vm._s(instruction.channel))]),
            _vm._v(" "),
            _c(
              "ol",
              _vm._l(instruction.step, function (step) {
                return _c("li", { key: step }, [_vm._v(_vm._s(step))])
              }),
              0
            ),
          ])
        }
      ),
    ],
    2
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue":
/*!****************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue ***!
  \****************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _pembayaran_instruction_vue_vue_type_template_id_b9422a2a___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./pembayaran-instruction.vue?vue&type=template&id=b9422a2a& */ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=template&id=b9422a2a&");
/* harmony import */ var _pembayaran_instruction_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./pembayaran-instruction.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue?vue&type=script&lang=js&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! !../../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */
;
var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _pembayaran_instruction_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _pembayaran_instruction_vue_vue_type_template_id_b9422a2a___WEBPACK_IMPORTED_MODULE_0__.render,
  _pembayaran_instruction_vue_vue_type_template_id_b9422a2a___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/Pembayaran/pembayaran-instruction.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ })

}]);