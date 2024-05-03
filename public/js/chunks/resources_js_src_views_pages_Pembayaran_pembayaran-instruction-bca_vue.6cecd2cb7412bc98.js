"use strict";
(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Pembayaran_pembayaran-instruction-bca_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js&":
/*!*************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js& ***!
  \*************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! core-js/modules/es.object.to-string.js */ "./node_modules/core-js/modules/es.object.to-string.js");
/* harmony import */ var core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_0__);

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
      response: {}
    };
  },
  mounted: function mounted() {
    var _this = this;

    var url = this.$route.params.howToPayApi;
    fetch(url).then(function (response) {
      return response.text();
    }).then(function (xmlString) {
      var parser = new DOMParser();
      var xmlDoc = parser.parseFromString(xmlString, 'text/xml');
      var responseNode = xmlDoc.getElementsByTagName('HowToPayResponseDto')[0];
      var clientNode = responseNode.getElementsByTagName('client')[0];
      var client = {
        id: clientNode.getElementsByTagName('id')[0].textContent,
        name: clientNode.getElementsByTagName('name')[0].textContent
      };
      var orderNode = responseNode.getElementsByTagName('order')[0];
      var order = {
        invoice_number: orderNode.getElementsByTagName('invoice_number')[0].textContent,
        amount: orderNode.getElementsByTagName('amount')[0].textContent
      };
      var virtualAccountNode = responseNode.getElementsByTagName('virtual_account_info')[0];
      var virtualAccountInfo = {
        virtual_account_number: virtualAccountNode.getElementsByTagName('virtual_account_number')[0].textContent,
        status: virtualAccountNode.getElementsByTagName('status')[0].textContent,
        created_date: virtualAccountNode.getElementsByTagName('created_date')[0].textContent,
        expired_date: virtualAccountNode.getElementsByTagName('expired_date')[0].textContent,
        expired_in: virtualAccountNode.getElementsByTagName('expired_in')[0].textContent
      };
      var customerNode = responseNode.getElementsByTagName('customer')[0];
      var customer = {
        name: customerNode.getElementsByTagName('name')[0].textContent,
        email: customerNode.getElementsByTagName('email')[0].textContent
      };
      var paymentInstructionNodes = responseNode.getElementsByTagName('payment_instruction');
      var paymentInstructions = [];

      for (var i = 0; i < paymentInstructionNodes.length; i++) {
        var instructionNode = paymentInstructionNodes[i];
        var channel = instructionNode.getElementsByTagName('channel')[0].textContent;
        var language = instructionNode.getElementsByTagName('language')[0].textContent;
        var stepNodes = instructionNode.getElementsByTagName('step');
        var steps = [];

        for (var j = 0; j < stepNodes.length; j++) {
          steps.push(stepNodes[j].textContent);
        }

        paymentInstructions.push({
          channel: channel,
          language: language,
          step: steps
        });
      }

      _this.response = {
        client: client,
        order: order,
        virtual_account_info: virtualAccountInfo,
        customer: customer,
        payment_instruction: paymentInstructions
      };
    })["catch"](function (error) {
      console.error('Error fetching XML:', error);
    });
  }
});

/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js&":
/*!*********************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pembayaran-instruction-bca.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&":
/*!***************************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& ***!
  \***************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&":
/*!******************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& ***!
  \******************************************************************************************************************************************************************************************************************************************************/
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
  return _c("div", [
    _c("h2", [_vm._v("Client:")]),
    _vm._v(" "),
    _c("p", [_vm._v("ID: " + _vm._s(_vm.response.client.id))]),
    _vm._v(" "),
    _c("p", [_vm._v("Name: " + _vm._s(_vm.response.client.name))]),
    _vm._v(" "),
    _c("h2", [_vm._v("Order:")]),
    _vm._v(" "),
    _c("p", [
      _vm._v("Invoice Number: " + _vm._s(_vm.response.order.invoice_number)),
    ]),
    _vm._v(" "),
    _c("p", [_vm._v("Amount: " + _vm._s(_vm.response.order.amount))]),
    _vm._v(" "),
    _c("h2", [_vm._v("Virtual Account Info:")]),
    _vm._v(" "),
    _c("p", [
      _vm._v(
        "Virtual Account Number: " +
          _vm._s(_vm.response.virtual_account_info.virtual_account_number)
      ),
    ]),
    _vm._v(" "),
    _c("p", [
      _vm._v("Status: " + _vm._s(_vm.response.virtual_account_info.status)),
    ]),
    _vm._v(" "),
    _c("p", [
      _vm._v(
        "Created Date: " +
          _vm._s(_vm.response.virtual_account_info.created_date)
      ),
    ]),
    _vm._v(" "),
    _c("p", [
      _vm._v(
        "Expired Date: " +
          _vm._s(_vm.response.virtual_account_info.expired_date)
      ),
    ]),
    _vm._v(" "),
    _c("p", [
      _vm._v(
        "Expired In: " + _vm._s(_vm.response.virtual_account_info.expired_in)
      ),
    ]),
    _vm._v(" "),
    _c("h2", [_vm._v("Customer:")]),
    _vm._v(" "),
    _c("p", [_vm._v("Name: " + _vm._s(_vm.response.customer.name))]),
    _vm._v(" "),
    _c("p", [_vm._v("Email: " + _vm._s(_vm.response.customer.email))]),
    _vm._v(" "),
    _c("h2", [_vm._v("Payment Instructions:")]),
    _vm._v(" "),
    _c(
      "ul",
      _vm._l(_vm.response.payment_instruction, function (instruction, index) {
        return _c("li", { key: index }, [
          _c("h3", [_vm._v("Channel: " + _vm._s(instruction.channel))]),
          _vm._v(" "),
          _c("h3", [_vm._v("Language: " + _vm._s(instruction.language))]),
          _vm._v(" "),
          _c(
            "ol",
            _vm._l(instruction.step, function (step, index) {
              return _c("li", { key: index }, [_vm._v(_vm._s(step))])
            }),
            0
          ),
        ])
      }),
      0
    ),
  ])
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue":
/*!********************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue ***!
  \********************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& */ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&");
/* harmony import */ var _pembayaran_instruction_bca_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./pembayaran-instruction-bca.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! !../../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */
;
var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _pembayaran_instruction_bca_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__.render,
  _pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ })

}]);