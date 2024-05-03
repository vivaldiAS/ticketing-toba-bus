(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Pembayaran_pembayaran-instruction-bca_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js&":
/*!*************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js& ***!
  \*************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
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
      response: {
        client: {},
        order: {},
        virtual_account_info: {},
        customer: {},
        payment_instruction: []
      }
    };
  },
  mounted: function mounted() {
    var _this = this;

    var url = this.$route.params.howToPayApi;
    fetch(url).then(function (response) {
      return response.text();
    }).then(function (xmlString) {
      var _clientNode$getElemen, _clientNode$getElemen2, _orderNode$getElement, _orderNode$getElement2, _virtualAccountNode$g, _virtualAccountNode$g2, _virtualAccountNode$g3, _virtualAccountNode$g4, _virtualAccountNode$g5, _customerNode$getElem, _customerNode$getElem2;

      var parser = new DOMParser();
      var xmlDoc = parser.parseFromString(xmlString, 'text/xml');
      var responseNode = xmlDoc.getElementsByTagName('HowToPayResponseDto')[0];
      var clientNode = responseNode.getElementsByTagName('client')[0];
      var client = {
        id: clientNode === null || clientNode === void 0 ? void 0 : (_clientNode$getElemen = clientNode.getElementsByTagName('id')[0]) === null || _clientNode$getElemen === void 0 ? void 0 : _clientNode$getElemen.textContent,
        name: clientNode === null || clientNode === void 0 ? void 0 : (_clientNode$getElemen2 = clientNode.getElementsByTagName('name')[0]) === null || _clientNode$getElemen2 === void 0 ? void 0 : _clientNode$getElemen2.textContent
      };
      var orderNode = responseNode.getElementsByTagName('order')[0];
      var order = {
        invoice_number: orderNode === null || orderNode === void 0 ? void 0 : (_orderNode$getElement = orderNode.getElementsByTagName('invoice_number')[0]) === null || _orderNode$getElement === void 0 ? void 0 : _orderNode$getElement.textContent,
        amount: orderNode === null || orderNode === void 0 ? void 0 : (_orderNode$getElement2 = orderNode.getElementsByTagName('amount')[0]) === null || _orderNode$getElement2 === void 0 ? void 0 : _orderNode$getElement2.textContent
      };
      var virtualAccountNode = responseNode.getElementsByTagName('virtual_account_info')[0];
      var virtualAccountInfo = {
        virtual_account_number: virtualAccountNode === null || virtualAccountNode === void 0 ? void 0 : (_virtualAccountNode$g = virtualAccountNode.getElementsByTagName('virtual_account_number')[0]) === null || _virtualAccountNode$g === void 0 ? void 0 : _virtualAccountNode$g.textContent,
        status: virtualAccountNode === null || virtualAccountNode === void 0 ? void 0 : (_virtualAccountNode$g2 = virtualAccountNode.getElementsByTagName('status')[0]) === null || _virtualAccountNode$g2 === void 0 ? void 0 : _virtualAccountNode$g2.textContent,
        created_date: virtualAccountNode === null || virtualAccountNode === void 0 ? void 0 : (_virtualAccountNode$g3 = virtualAccountNode.getElementsByTagName('created_date')[0]) === null || _virtualAccountNode$g3 === void 0 ? void 0 : _virtualAccountNode$g3.textContent,
        expired_date: virtualAccountNode === null || virtualAccountNode === void 0 ? void 0 : (_virtualAccountNode$g4 = virtualAccountNode.getElementsByTagName('expired_date')[0]) === null || _virtualAccountNode$g4 === void 0 ? void 0 : _virtualAccountNode$g4.textContent,
        expired_in: virtualAccountNode === null || virtualAccountNode === void 0 ? void 0 : (_virtualAccountNode$g5 = virtualAccountNode.getElementsByTagName('expired_in')[0]) === null || _virtualAccountNode$g5 === void 0 ? void 0 : _virtualAccountNode$g5.textContent
      };
      var customerNode = responseNode.getElementsByTagName('customer')[0];
      var customer = {
        name: customerNode === null || customerNode === void 0 ? void 0 : (_customerNode$getElem = customerNode.getElementsByTagName('name')[0]) === null || _customerNode$getElem === void 0 ? void 0 : _customerNode$getElem.textContent,
        email: customerNode === null || customerNode === void 0 ? void 0 : (_customerNode$getElem2 = customerNode.getElementsByTagName('email')[0]) === null || _customerNode$getElem2 === void 0 ? void 0 : _customerNode$getElem2.textContent
      };
      var paymentInstructionNodes = responseNode.getElementsByTagName('payment_instruction');
      var paymentInstructions = [];

      for (var i = 0; i < paymentInstructionNodes.length; i++) {
        var _instructionNode$getE, _instructionNode$getE2;

        var instructionNode = paymentInstructionNodes[i];
        var channel = (_instructionNode$getE = instructionNode.getElementsByTagName('channel')[0]) === null || _instructionNode$getE === void 0 ? void 0 : _instructionNode$getE.textContent;
        var language = (_instructionNode$getE2 = instructionNode.getElementsByTagName('language')[0]) === null || _instructionNode$getE2 === void 0 ? void 0 : _instructionNode$getE2.textContent;
        var stepNodes = instructionNode.getElementsByTagName('step');
        var steps = [];

        for (var j = 0; j < stepNodes.length; j++) {
          var _stepNodes$j;

          steps.push((_stepNodes$j = stepNodes[j]) === null || _stepNodes$j === void 0 ? void 0 : _stepNodes$j.textContent);
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

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pembayaran-instruction-bca.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&":
/*!***************************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& ***!
  \***************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pembayaran_instruction_bca_vue_vue_type_template_id_0a12c8de___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de&":
/*!******************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue?vue&type=template&id=0a12c8de& ***!
  \******************************************************************************************************************************************************************************************************************************************************/
/***/ (function() {

throw new Error("Module build failed (from ./node_modules/vue-loader/lib/loaders/templateLoader.js):\nSyntaxError: Unexpected token (1:128)\n    at pp$4.raise (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2757:13)\n    at pp.unexpected (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:647:8)\n    at pp$3.parseExprAtom (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2196:10)\n    at Parser.<anonymous> (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:6003:24)\n    at Parser.parseExprAtom (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:6129:31)\n    at pp$3.parseExprSubscripts (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2047:19)\n    at pp$3.parseMaybeUnary (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2024:17)\n    at pp$3.parseExprOps (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:1966:19)\n    at pp$3.parseMaybeConditional (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:1949:19)\n    at pp$3.parseMaybeAssign (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:1925:19)\n    at pp$3.parseMaybeConditional (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:1954:28)\n    at pp$3.parseMaybeAssign (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:1925:19)\n    at pp$3.parseExprList (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2663:20)\n    at pp$3.parseSubscripts (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2075:29)\n    at pp$3.parseExprSubscripts (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2050:21)\n    at pp$3.parseMaybeUnary (D:\\Other\\LARAVUE\\APP\\DantobBuss-Application\\node_modules\\vue-template-es2015-compiler\\buble.js:2024:17)");

/***/ }),

/***/ "./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue":
/*!********************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pembayaran/pembayaran-instruction-bca.vue ***!
  \********************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
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