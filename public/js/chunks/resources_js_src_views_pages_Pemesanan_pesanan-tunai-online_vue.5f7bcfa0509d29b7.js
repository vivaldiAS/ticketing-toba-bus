"use strict";
(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Pemesanan_pesanan-tunai-online_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=script&lang=js&":
/*!******************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=script&lang=js& ***!
  \******************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! axios */ "./node_modules/axios/index.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var sweetalert2__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! sweetalert2 */ "./node_modules/sweetalert2/dist/sweetalert2.all.js");
/* harmony import */ var sweetalert2__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(sweetalert2__WEBPACK_IMPORTED_MODULE_1__);
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
      bookings: []
    };
  },
  methods: {
    getBookings: function getBookings() {
      var _this = this;

      var id = this.$route.params.id;
      axios__WEBPACK_IMPORTED_MODULE_0___default().get("/api/pesanan-online/".concat(id)).then(function (response) {
        _this.bookings = response.data;
      })["catch"](function (error) {
        console.error(error);
      });
    },
    confirmBooking: function confirmBooking(id) {// Implementasi logika untuk mengkonfirmasi booking
    },
    cancelBooking: function cancelBooking(id) {// Implementasi logika untuk membatalkan booking
    },
    calculateTotalPrice: function calculateTotalPrice(booking) {
      return booking.harga * booking.num_seats;
    }
  },
  mounted: function mounted() {
    this.getBookings();
  }
});

/***/ }),

/***/ "./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=script&lang=js&":
/*!**************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=script&lang=js& ***!
  \**************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pesanan_tunai_online_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pesanan-tunai-online.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_pesanan_tunai_online_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=template&id=1fc00444&":
/*!********************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=template&id=1fc00444& ***!
  \********************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pesanan_tunai_online_vue_vue_type_template_id_1fc00444___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pesanan_tunai_online_vue_vue_type_template_id_1fc00444___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_pesanan_tunai_online_vue_vue_type_template_id_1fc00444___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./pesanan-tunai-online.vue?vue&type=template&id=1fc00444& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=template&id=1fc00444&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=template&id=1fc00444&":
/*!***********************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=template&id=1fc00444& ***!
  \***********************************************************************************************************************************************************************************************************************************************/
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
    _c("h1", [_vm._v("List Bujank")]),
    _vm._v(" "),
    _vm.bookings.length === 0
      ? _c("div", [_c("p", [_vm._v("Tidak ada booking yang tersedia.")])])
      : _c(
          "div",
          _vm._l(_vm.bookings, function (booking) {
            return _c("div", { key: booking.id }, [
              _c("p", [_vm._v("Nama: " + _vm._s(booking.name))]),
              _vm._v(" "),
              _c("p", [_vm._v("Jumlah Seat: " + _vm._s(booking.num_seats))]),
              _vm._v(" "),
              _c("p", [
                _vm._v(
                  "Harga Total: " + _vm._s(_vm.calculateTotalPrice(booking))
                ),
              ]),
              _vm._v(" "),
              _c(
                "button",
                {
                  on: {
                    click: function ($event) {
                      return _vm.confirmBooking(booking.id)
                    },
                  },
                },
                [_vm._v("Konfirmasi")]
              ),
              _vm._v(" "),
              _c(
                "button",
                {
                  on: {
                    click: function ($event) {
                      return _vm.cancelBooking(booking.id)
                    },
                  },
                },
                [_vm._v("Batalkan")]
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

/***/ "./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue":
/*!*************************************************************************!*\
  !*** ./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue ***!
  \*************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _pesanan_tunai_online_vue_vue_type_template_id_1fc00444___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./pesanan-tunai-online.vue?vue&type=template&id=1fc00444& */ "./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=template&id=1fc00444&");
/* harmony import */ var _pesanan_tunai_online_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./pesanan-tunai-online.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue?vue&type=script&lang=js&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! !../../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */
;
var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _pesanan_tunai_online_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _pesanan_tunai_online_vue_vue_type_template_id_1fc00444___WEBPACK_IMPORTED_MODULE_0__.render,
  _pesanan_tunai_online_vue_vue_type_template_id_1fc00444___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/Pemesanan/pesanan-tunai-online.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ })

}]);