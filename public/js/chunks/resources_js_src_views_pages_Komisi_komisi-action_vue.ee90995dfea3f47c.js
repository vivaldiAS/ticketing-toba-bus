(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Komisi_komisi-action_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=script&lang=js&":
/*!********************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=script&lang=js& ***!
  \********************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var E_laragon_www_DantobBuss_Application_node_modules_babel_runtime_helpers_esm_objectSpread2__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./node_modules/@babel/runtime/helpers/esm/objectSpread2 */ "./node_modules/@babel/runtime/helpers/esm/objectSpread2.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! axios */ "./node_modules/axios/index.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _mdi_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @mdi/js */ "./node_modules/@mdi/js/mdi.js");

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
  setup: function setup() {
    return {
      icons: {
        mdiPencil: _mdi_js__WEBPACK_IMPORTED_MODULE_2__.mdiPencil,
        mdiContentSave: _mdi_js__WEBPACK_IMPORTED_MODULE_2__.mdiContentSave,
        mdiClose: _mdi_js__WEBPACK_IMPORTED_MODULE_2__.mdiClose
      }
    };
  },
  data: function data() {
    return {
      id: null,
      persentaseKomisi: 0,
      setoranKantor: 0,
      administrasi: 0,
      brandId: 0,
      isEditing: false,
      editedData: {
        id: null,
        persentase_komisi: 0,
        setoran_kantor: 0,
        administrasi: 0,
        brand_id: 0
      }
    };
  },
  mounted: function mounted() {
    var _this = this;

    var access_token = localStorage.getItem("access_token");
    axios__WEBPACK_IMPORTED_MODULE_1___default().get('/api/komisi', {
      headers: {
        Authorization: "Bearer ".concat(access_token)
      }
    }).then(function (response) {
      var komisiData = response.data.data[0];
      _this.id = komisiData.id;
      _this.persentaseKomisi = komisiData.persentase_komisi;
      _this.setoranKantor = komisiData.setoran_kantor;
      _this.administrasi = komisiData.administrasi;
      _this.brandId = komisiData.brand_id;
      _this.editedData = (0,E_laragon_www_DantobBuss_Application_node_modules_babel_runtime_helpers_esm_objectSpread2__WEBPACK_IMPORTED_MODULE_0__["default"])({}, komisiData);
    })["catch"](function (error) {
      console.log(error);
    });
  },
  methods: {
    editFields: function editFields() {
      this.isEditing = true;
    },
    saveEdit: function saveEdit() {
      var _this2 = this;

      var access_token = localStorage.getItem("access_token");
      axios__WEBPACK_IMPORTED_MODULE_1___default().put('/api/komisi', this.editedData, {
        headers: {
          Authorization: "Bearer ".concat(access_token)
        }
      }).then(function (response) {
        _this2.persentaseKomisi = _this2.editedData.persentase_komisi;
        _this2.setoranKantor = _this2.editedData.setoran_kantor;
        _this2.administrasi = _this2.editedData.administrasi;
        _this2.brandId = _this2.editedData.brand_id;
        _this2.isEditing = false;
        console.log(response.data);
      })["catch"](function (error) {
        console.log(error);
      });
    },
    cancelEdit: function cancelEdit() {
      this.editedData = {
        id: this.id,
        persentase_komisi: this.persentaseKomisi,
        setoran_kantor: this.setoranKantor,
        administrasi: this.administrasi,
        brand_id: this.brandId
      };
      this.isEditing = false;
    }
  },
  filters: {
    toRupiah: function toRupiah(value) {
      var formatter = new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0
      });
      return formatter.format(value);
    }
  }
});

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-21[0].rules[0].use[2]!./node_modules/vuetify/src/components/VDataTable/VSimpleTable.sass":
/*!********************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-21[0].rules[0].use[2]!./node_modules/vuetify/src/components/VDataTable/VSimpleTable.sass ***!
  \********************************************************************************************************************************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _css_loader_dist_runtime_noSourceMaps_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../../../css-loader/dist/runtime/noSourceMaps.js */ "./node_modules/css-loader/dist/runtime/noSourceMaps.js");
/* harmony import */ var _css_loader_dist_runtime_noSourceMaps_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_css_loader_dist_runtime_noSourceMaps_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js");
/* harmony import */ var _css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1__);
// Imports


var ___CSS_LOADER_EXPORT___ = _css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1___default()((_css_loader_dist_runtime_noSourceMaps_js__WEBPACK_IMPORTED_MODULE_0___default()));
// Module
___CSS_LOADER_EXPORT___.push([module.id, ".theme--light.v-data-table {\n  background-color: #fff;\n  color: rgba(29, 70, 70, 0.87);\n}\n.theme--light.v-data-table .v-data-table__divider {\n  border-right: thin solid rgba(29, 70, 70, 0.14);\n}\n.theme--light.v-data-table.v-data-table--fixed-header thead th {\n  background: #fff;\n  box-shadow: inset 0 -1px 0 rgba(29, 70, 70, 0.14);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > thead > tr > th {\n  color: rgba(29, 70, 70, 0.68);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > thead > tr:last-child > th {\n  border-bottom: thin solid rgba(29, 70, 70, 0.14);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > td:not(.v-data-table__mobile-row),\n.theme--light.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > th:not(.v-data-table__mobile-row) {\n  border-bottom: thin solid rgba(29, 70, 70, 0.14);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > td:last-child,\n.theme--light.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > th:last-child {\n  border-bottom: thin solid rgba(29, 70, 70, 0.14);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > tbody > tr.active {\n  background: rgba(29, 70, 70, 0.08);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > tbody > tr:hover:not(.v-data-table__expanded__content):not(.v-data-table__empty-wrapper) {\n  background: rgba(29, 70, 70, 0.04);\n}\n.theme--light.v-data-table > .v-data-table__wrapper > table > tfoot > tr > td:not(.v-data-table__mobile-row),\n.theme--light.v-data-table > .v-data-table__wrapper > table > tfoot > tr > th:not(.v-data-table__mobile-row) {\n  border-top: thin solid rgba(29, 70, 70, 0.14);\n}\n\n.theme--dark.v-data-table {\n  background-color: #312d4b;\n  color: rgba(231, 227, 252, 0.87);\n}\n.theme--dark.v-data-table .v-data-table__divider {\n  border-right: thin solid rgba(231, 227, 252, 0.14);\n}\n.theme--dark.v-data-table.v-data-table--fixed-header thead th {\n  background: #312d4b;\n  box-shadow: inset 0 -1px 0 rgba(231, 227, 252, 0.14);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > thead > tr > th {\n  color: rgba(231, 227, 252, 0.68);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > thead > tr:last-child > th {\n  border-bottom: thin solid rgba(231, 227, 252, 0.14);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > td:not(.v-data-table__mobile-row),\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > th:not(.v-data-table__mobile-row) {\n  border-bottom: thin solid rgba(231, 227, 252, 0.14);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > td:last-child,\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tbody > tr:not(:last-child) > th:last-child {\n  border-bottom: thin solid rgba(231, 227, 252, 0.14);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tbody > tr.active {\n  background: rgba(231, 227, 252, 0.08);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tbody > tr:hover:not(.v-data-table__expanded__content):not(.v-data-table__empty-wrapper) {\n  background: rgba(231, 227, 252, 0.04);\n}\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tfoot > tr > td:not(.v-data-table__mobile-row),\n.theme--dark.v-data-table > .v-data-table__wrapper > table > tfoot > tr > th:not(.v-data-table__mobile-row) {\n  border-top: thin solid rgba(231, 227, 252, 0.14);\n}\n\n.v-data-table {\n  line-height: 1.5;\n  max-width: 100%;\n}\n.v-data-table > .v-data-table__wrapper > table {\n  width: 100%;\n  border-spacing: 0;\n}\n.v-data-table > .v-data-table__wrapper > table > tbody > tr > td,\n.v-data-table > .v-data-table__wrapper > table > tbody > tr > th,\n.v-data-table > .v-data-table__wrapper > table > thead > tr > td,\n.v-data-table > .v-data-table__wrapper > table > thead > tr > th,\n.v-data-table > .v-data-table__wrapper > table > tfoot > tr > td,\n.v-data-table > .v-data-table__wrapper > table > tfoot > tr > th {\n  padding: 0 16px;\n  transition: height 0.2s cubic-bezier(0.4, 0, 0.6, 1);\n}\n.v-data-table > .v-data-table__wrapper > table > tbody > tr > th,\n.v-data-table > .v-data-table__wrapper > table > thead > tr > th,\n.v-data-table > .v-data-table__wrapper > table > tfoot > tr > th {\n  user-select: none;\n  font-size: 0.75rem;\n  height: 3.375rem;\n}\n.v-application--is-ltr .v-data-table > .v-data-table__wrapper > table > tbody > tr > th,\n.v-application--is-ltr .v-data-table > .v-data-table__wrapper > table > thead > tr > th,\n.v-application--is-ltr .v-data-table > .v-data-table__wrapper > table > tfoot > tr > th {\n  text-align: left;\n}\n.v-application--is-rtl .v-data-table > .v-data-table__wrapper > table > tbody > tr > th,\n.v-application--is-rtl .v-data-table > .v-data-table__wrapper > table > thead > tr > th,\n.v-application--is-rtl .v-data-table > .v-data-table__wrapper > table > tfoot > tr > th {\n  text-align: right;\n}\n.v-data-table > .v-data-table__wrapper > table > tbody > tr > td,\n.v-data-table > .v-data-table__wrapper > table > thead > tr > td,\n.v-data-table > .v-data-table__wrapper > table > tfoot > tr > td {\n  font-size: 0.875rem;\n  height: 3.125rem;\n}\n\n.v-data-table__wrapper {\n  overflow-x: auto;\n  overflow-y: hidden;\n}\n\n.v-data-table__progress {\n  height: auto !important;\n}\n.v-data-table__progress th {\n  height: auto !important;\n  border: none !important;\n  padding: 0;\n  position: relative;\n}\n\n.v-data-table--dense > .v-data-table__wrapper > table > tbody > tr > td,\n.v-data-table--dense > .v-data-table__wrapper > table > thead > tr > td,\n.v-data-table--dense > .v-data-table__wrapper > table > tfoot > tr > td {\n  height: 2.125rem;\n}\n.v-data-table--dense > .v-data-table__wrapper > table > tbody > tr > th,\n.v-data-table--dense > .v-data-table__wrapper > table > thead > tr > th,\n.v-data-table--dense > .v-data-table__wrapper > table > tfoot > tr > th {\n  height: 2.375rem;\n}\n\n.v-data-table--has-top > .v-data-table__wrapper > table > tbody > tr:first-child:hover > td:first-child {\n  border-top-left-radius: 0;\n}\n.v-data-table--has-top > .v-data-table__wrapper > table > tbody > tr:first-child:hover > td:last-child {\n  border-top-right-radius: 0;\n}\n\n.v-data-table--has-bottom > .v-data-table__wrapper > table > tbody > tr:last-child:hover > td:first-child {\n  border-bottom-left-radius: 0;\n}\n.v-data-table--has-bottom > .v-data-table__wrapper > table > tbody > tr:last-child:hover > td:last-child {\n  border-bottom-right-radius: 0;\n}\n\n.v-data-table--fixed-height .v-data-table__wrapper {\n  overflow-y: auto;\n}\n\n.v-data-table--fixed-header > .v-data-table__wrapper {\n  overflow-y: auto;\n}\n.v-data-table--fixed-header > .v-data-table__wrapper > table > thead > tr > th {\n  border-bottom: 0px !important;\n  position: sticky;\n  top: 0;\n  z-index: 2;\n}\n.v-data-table--fixed-header > .v-data-table__wrapper > table > thead > tr:nth-child(2) > th {\n  top: 3.375rem;\n}\n.v-application--is-ltr .v-data-table--fixed-header .v-data-footer {\n  margin-right: 17px;\n}\n.v-application--is-rtl .v-data-table--fixed-header .v-data-footer {\n  margin-left: 17px;\n}\n\n.v-data-table--fixed-header.v-data-table--dense > .v-data-table__wrapper > table > thead > tr:nth-child(2) > th {\n  top: 2.375rem;\n}", ""]);
// Exports
/* harmony default export */ __webpack_exports__["default"] = (___CSS_LOADER_EXPORT___);


/***/ }),

/***/ "./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css&":
/*!******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css& ***!
  \******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../../../../../node_modules/laravel-mix/node_modules/css-loader/dist/runtime/api.js */ "./node_modules/laravel-mix/node_modules/css-loader/dist/runtime/api.js");
/* harmony import */ var _node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__);
// Imports

var ___CSS_LOADER_EXPORT___ = _node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default()(function(i){return i[1]});
// Module
___CSS_LOADER_EXPORT___.push([module.id, "\n.table-primary[data-v-2b948bae] {\n  width: 100%;\n  border-collapse: collapse;\n}\n.table-primary th[data-v-2b948bae],\n.table-primary td[data-v-2b948bae] {\n  padding: 12px;\n  border: 1px solid #ccc;\n}\n.table-primary th[data-v-2b948bae] {\n  background-color: var(--v-primary-base);\n  color: white;\n}\n.btn[data-v-2b948bae] {\n  display: inline-flex;\n  align-items: center;\n  gap: 5px;\n  padding: 8px 12px;\n  border: none;\n  border-radius: 4px;\n  cursor: pointer;\n}\n.btn-primary[data-v-2b948bae] {\n  background-color: var(--v-primary-base);\n  color: white;\n}\n.btn-danger[data-v-2b948bae] {\n  background-color: red;\n  color: white;\n}\n", ""]);
// Exports
/* harmony default export */ __webpack_exports__["default"] = (___CSS_LOADER_EXPORT___);


/***/ }),

/***/ "./node_modules/style-loader/dist/cjs.js!./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css&":
/*!**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/style-loader/dist/cjs.js!./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css& ***!
  \**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! !../../../../../../node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js");
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_style_index_0_id_2b948bae_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! !!../../../../../../node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!../../../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../../../node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css& */ "./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css&");

            

var options = {};

options.insert = "head";
options.singleton = false;

var update = _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default()(_node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_style_index_0_id_2b948bae_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_1__["default"], options);



/* harmony default export */ __webpack_exports__["default"] = (_node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_style_index_0_id_2b948bae_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_1__["default"].locals || {});

/***/ }),

/***/ "./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=script&lang=js&":
/*!****************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=script&lang=js& ***!
  \****************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./komisi-action.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css&":
/*!************************************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css& ***!
  \************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_cjs_js_node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_8_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_style_index_0_id_2b948bae_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/style-loader/dist/cjs.js!../../../../../../node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!../../../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../../../node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css& */ "./node_modules/style-loader/dist/cjs.js!./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-8[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css&");


/***/ }),

/***/ "./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=template&id=2b948bae&scoped=true&":
/*!**********************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=template&id=2b948bae&scoped=true& ***!
  \**********************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_template_id_2b948bae_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_template_id_2b948bae_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_komisi_action_vue_vue_type_template_id_2b948bae_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./komisi-action.vue?vue&type=template&id=2b948bae&scoped=true& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=template&id=2b948bae&scoped=true&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=template&id=2b948bae&scoped=true&":
/*!*************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=template&id=2b948bae&scoped=true& ***!
  \*************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
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
      _c("h2", [_vm._v("Informasi Komisi")]),
      _vm._v(" "),
      _c("v-simple-table", {
        staticClass: "mt-4 table-primary",
        scopedSlots: _vm._u([
          {
            key: "default",
            fn: function () {
              return [
                _c("thead", [
                  _c("tr", [
                    _c("th", [_vm._v("Persentase Komisi")]),
                    _vm._v(" "),
                    _c("th", [_vm._v("Setoran Kantor")]),
                    _vm._v(" "),
                    _c("th", [_vm._v("Administrasi")]),
                    _vm._v(" "),
                    _c("th", [_vm._v("Aksi")]),
                  ]),
                ]),
                _vm._v(" "),
                _c("tbody", [
                  _c("tr", [
                    _c("td", [
                      _vm.isEditing
                        ? _c("div", [
                            _c("input", {
                              directives: [
                                {
                                  name: "model",
                                  rawName: "v-model",
                                  value: _vm.editedData.persentase_komisi,
                                  expression: "editedData.persentase_komisi",
                                },
                              ],
                              attrs: { type: "number" },
                              domProps: {
                                value: _vm.editedData.persentase_komisi,
                              },
                              on: {
                                input: function ($event) {
                                  if ($event.target.composing) {
                                    return
                                  }
                                  _vm.$set(
                                    _vm.editedData,
                                    "persentase_komisi",
                                    $event.target.value
                                  )
                                },
                              },
                            }),
                          ])
                        : _c("div", [
                            _vm._v(_vm._s(_vm.persentaseKomisi) + "%"),
                          ]),
                    ]),
                    _vm._v(" "),
                    _c("td", [
                      _vm.isEditing
                        ? _c("div", [
                            _c("input", {
                              directives: [
                                {
                                  name: "model",
                                  rawName: "v-model",
                                  value: _vm.editedData.setoran_kantor,
                                  expression: "editedData.setoran_kantor",
                                },
                              ],
                              attrs: { type: "number" },
                              domProps: {
                                value: _vm.editedData.setoran_kantor,
                              },
                              on: {
                                input: function ($event) {
                                  if ($event.target.composing) {
                                    return
                                  }
                                  _vm.$set(
                                    _vm.editedData,
                                    "setoran_kantor",
                                    $event.target.value
                                  )
                                },
                              },
                            }),
                          ])
                        : _c("div", [
                            _vm._v(
                              _vm._s(_vm._f("toRupiah")(_vm.setoranKantor))
                            ),
                          ]),
                    ]),
                    _vm._v(" "),
                    _c("td", [
                      _vm.isEditing
                        ? _c("div", [
                            _c("input", {
                              directives: [
                                {
                                  name: "model",
                                  rawName: "v-model",
                                  value: _vm.editedData.administrasi,
                                  expression: "editedData.administrasi",
                                },
                              ],
                              attrs: { type: "number" },
                              domProps: { value: _vm.editedData.administrasi },
                              on: {
                                input: function ($event) {
                                  if ($event.target.composing) {
                                    return
                                  }
                                  _vm.$set(
                                    _vm.editedData,
                                    "administrasi",
                                    $event.target.value
                                  )
                                },
                              },
                            }),
                          ])
                        : _c("div", [
                            _vm._v(
                              _vm._s(_vm._f("toRupiah")(_vm.administrasi))
                            ),
                          ]),
                    ]),
                    _vm._v(" "),
                    _c("td", [
                      _vm.isEditing
                        ? _c(
                            "button",
                            {
                              staticClass: "btn btn-primary",
                              on: { click: _vm.saveEdit },
                            },
                            [
                              _c("v-icon", { attrs: { color: "white" } }, [
                                _vm._v(_vm._s(_vm.icons.mdiContentSave)),
                              ]),
                            ],
                            1
                          )
                        : _vm._e(),
                      _vm._v(" "),
                      _vm.isEditing
                        ? _c(
                            "button",
                            {
                              staticClass: "btn btn-danger",
                              on: { click: _vm.cancelEdit },
                            },
                            [
                              _c("v-icon", { attrs: { color: "white" } }, [
                                _vm._v(_vm._s(_vm.icons.mdiClose)),
                              ]),
                            ],
                            1
                          )
                        : _c(
                            "button",
                            {
                              staticClass: "btn btn-primary",
                              on: { click: _vm.editFields },
                            },
                            [
                              _c("v-icon", { attrs: { color: "white" } }, [
                                _vm._v(_vm._s(_vm.icons.mdiPencil)),
                              ]),
                            ],
                            1
                          ),
                    ]),
                  ]),
                ]),
              ]
            },
            proxy: true,
          },
        ]),
      }),
    ],
    1
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./node_modules/vuetify/src/components/VDataTable/VSimpleTable.sass":
/*!**************************************************************************!*\
  !*** ./node_modules/vuetify/src/components/VDataTable/VSimpleTable.sass ***!
  \**************************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(/*! !!../../../../css-loader/dist/cjs.js!../../../../sass-loader/dist/cjs.js??clonedRuleSet-21[0].rules[0].use[2]!./VSimpleTable.sass */ "./node_modules/css-loader/dist/cjs.js!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-21[0].rules[0].use[2]!./node_modules/vuetify/src/components/VDataTable/VSimpleTable.sass");
if(content.__esModule) content = content.default;
if(typeof content === 'string') content = [[module.id, content, '']];
if(content.locals) module.exports = content.locals;
// add the styles to the DOM
var add = (__webpack_require__(/*! !../../../../vue-style-loader/lib/addStylesClient.js */ "./node_modules/vue-style-loader/lib/addStylesClient.js")["default"])
var update = add("5474e9c8", content, false, {});
// Hot Module Replacement
if(false) {}

/***/ }),

/***/ "./resources/js/src/views/pages/Komisi/komisi-action.vue":
/*!***************************************************************!*\
  !*** ./resources/js/src/views/pages/Komisi/komisi-action.vue ***!
  \***************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _komisi_action_vue_vue_type_template_id_2b948bae_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./komisi-action.vue?vue&type=template&id=2b948bae&scoped=true& */ "./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=template&id=2b948bae&scoped=true&");
/* harmony import */ var _komisi_action_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./komisi-action.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=script&lang=js&");
/* harmony import */ var _komisi_action_vue_vue_type_style_index_0_id_2b948bae_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css& */ "./resources/js/src/views/pages/Komisi/komisi-action.vue?vue&type=style&index=0&id=2b948bae&scoped=true&lang=css&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! !../../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! !../../../../../../node_modules/vuetify-loader/lib/runtime/installComponents.js */ "./node_modules/vuetify-loader/lib/runtime/installComponents.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4__);
/* harmony import */ var vuetify_lib_components_VIcon__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! vuetify/lib/components/VIcon */ "./node_modules/vuetify/lib/components/VIcon/VIcon.js");
/* harmony import */ var vuetify_lib_components_VDataTable__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! vuetify/lib/components/VDataTable */ "./node_modules/vuetify/lib/components/VDataTable/VSimpleTable.js");



;


/* normalize component */

var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__["default"])(
  _komisi_action_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _komisi_action_vue_vue_type_template_id_2b948bae_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render,
  _komisi_action_vue_vue_type_template_id_2b948bae_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  "2b948bae",
  null
  
)

/* vuetify-loader */
;


_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4___default()(component, {VIcon: vuetify_lib_components_VIcon__WEBPACK_IMPORTED_MODULE_5__["default"],VSimpleTable: vuetify_lib_components_VDataTable__WEBPACK_IMPORTED_MODULE_6__["default"]})


/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/Komisi/komisi-action.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./node_modules/vuetify/lib/components/VDataTable/VSimpleTable.js":
/*!************************************************************************!*\
  !*** ./node_modules/vuetify/lib/components/VDataTable/VSimpleTable.js ***!
  \************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _src_components_VDataTable_VSimpleTable_sass__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../../src/components/VDataTable/VSimpleTable.sass */ "./node_modules/vuetify/src/components/VDataTable/VSimpleTable.sass");
/* harmony import */ var _src_components_VDataTable_VSimpleTable_sass__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_src_components_VDataTable_VSimpleTable_sass__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _util_helpers__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../util/helpers */ "./node_modules/vuetify/lib/util/helpers.js");
/* harmony import */ var _mixins_themeable__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../mixins/themeable */ "./node_modules/vuetify/lib/mixins/themeable/index.js");
/* harmony import */ var _util_mixins__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../util/mixins */ "./node_modules/vuetify/lib/util/mixins.js");




/* harmony default export */ __webpack_exports__["default"] = ((0,_util_mixins__WEBPACK_IMPORTED_MODULE_1__["default"])(_mixins_themeable__WEBPACK_IMPORTED_MODULE_2__["default"]).extend({
  name: 'v-simple-table',
  props: {
    dense: Boolean,
    fixedHeader: Boolean,
    height: [Number, String]
  },
  computed: {
    classes() {
      return {
        'v-data-table--dense': this.dense,
        'v-data-table--fixed-height': !!this.height && !this.fixedHeader,
        'v-data-table--fixed-header': this.fixedHeader,
        'v-data-table--has-top': !!this.$slots.top,
        'v-data-table--has-bottom': !!this.$slots.bottom,
        ...this.themeClasses
      };
    }

  },
  methods: {
    genWrapper() {
      return this.$slots.wrapper || this.$createElement('div', {
        staticClass: 'v-data-table__wrapper',
        style: {
          height: (0,_util_helpers__WEBPACK_IMPORTED_MODULE_3__.convertToUnit)(this.height)
        }
      }, [this.$createElement('table', this.$slots.default)]);
    }

  },

  render(h) {
    return h('div', {
      staticClass: 'v-data-table',
      class: this.classes
    }, [this.$slots.top, this.genWrapper(), this.$slots.bottom]);
  }

}));
//# sourceMappingURL=VSimpleTable.js.map

/***/ })

}]);