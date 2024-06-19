"use strict";
(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Mobil_add-mobil_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=script&lang=js&":
/*!***************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=script&lang=js& ***!
  \***************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_map_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! core-js/modules/es.array.map.js */ "./node_modules/core-js/modules/es.array.map.js");
/* harmony import */ var core_js_modules_es_array_map_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_map_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var core_js_modules_es_array_filter_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! core-js/modules/es.array.filter.js */ "./node_modules/core-js/modules/es.array.filter.js");
/* harmony import */ var core_js_modules_es_array_filter_js__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_filter_js__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! core-js/modules/es.object.to-string.js */ "./node_modules/core-js/modules/es.object.to-string.js");
/* harmony import */ var core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var core_js_modules_es_function_name_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! core-js/modules/es.function.name.js */ "./node_modules/core-js/modules/es.function.name.js");
/* harmony import */ var core_js_modules_es_function_name_js__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_function_name_js__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var _vue_composition_api__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @vue/composition-api */ "./node_modules/@vue/composition-api/dist/vue-composition-api.mjs");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! axios */ "./node_modules/axios/index.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_4__);
/* harmony import */ var sweetalert2__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! sweetalert2 */ "./node_modules/sweetalert2/dist/sweetalert2.all.js");
/* harmony import */ var sweetalert2__WEBPACK_IMPORTED_MODULE_5___default = /*#__PURE__*/__webpack_require__.n(sweetalert2__WEBPACK_IMPORTED_MODULE_5__);




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
    var police_number = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_6__.ref)("");
    var num_seats = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_6__.ref)("");
    var type = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_6__.ref)();
    var status = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_6__.ref)();
    var driver = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_6__.ref)();
    var errors = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_6__.ref)({});
    return {
      police_number: police_number,
      num_seats: num_seats,
      type: type,
      status: status,
      driver: driver,
      errors: errors,
      mobil: ["police_number", "type", "driver", "number_of_seats", "nomor_pintu", "merk_id", "status"]
    };
  },
  data: function data() {
    return {
      supir: [],
      driver: null,
      loket: null,
      mobil: []
    };
  },
  mounted: function mounted() {
    var _this = this;

    var access_token = localStorage.getItem("access_token");
    axios__WEBPACK_IMPORTED_MODULE_4___default().get("/api/buss/show/notAssociated", {
      headers: {
        Authorization: "Bearer ".concat(access_token)
      }
    }).then(function (response) {
      _this.supir = response.data.filter(function (item) {
        return item.status == 1;
      }) // Filter dengan supir.status = 1
      .map(function (item) {
        return {
          name: item.name,
          id: item.id
        };
      });
      console.log("ini", _this.supir);
    })["catch"](function (error) {
      console.log(error);
    }); // Loket Get

    axios__WEBPACK_IMPORTED_MODULE_4___default().get("/api/loket/all", {
      headers: {
        Authorization: "Bearer ".concat(access_token)
      }
    }).then(function (response) {
      _this.loket = response.data.filter(function (item) {
        return item.status == 1;
      }) // Filter dengan supir.status = 1
      .map(function (item) {
        return {
          name: item.nama_loket,
          id: item.id
        };
      });
    })["catch"](function (error) {
      console.log(error);
    });
  },
  methods: {
    selectType: function selectType() {
      if (this.mobil.type === "Ekonomi") {
        this.mobil.number_of_seats = "12";
      } else if (this.mobil.type === "Eksekutif") {
        this.mobil.number_of_seats = "12";
      }
    },
    AddMobil: function AddMobil() {
      var _this2 = this;

      var access_token = localStorage.getItem("access_token");
      axios__WEBPACK_IMPORTED_MODULE_4___default().post("/api/buss/add", {
        police_number: this.mobil.police_number,
        type: this.mobil.type,
        supir_id: this.mobil.driver,
        number_of_seats: this.mobil.number_of_seats,
        nomor_pintu: this.mobil.nomor_pintu,
        merk_id: '1',
        loket_id: this.mobil.loket
      }, {
        headers: {
          Authorization: "Bearer ".concat(access_token)
        }
      }).then(function (response) {
        _this2.message = response.data.message;
        sweetalert2__WEBPACK_IMPORTED_MODULE_5___default().fire({
          icon: "success",
          title: "Berhasil",
          text: _this2.message
        });

        _this2.$router.push({
          name: "pages-mobil",
          query: {
            message: _this2.message
          }
        });
      })["catch"](function (error) {
        if (error.response.status === 422) {
          _this2.errors = error.response.data.data;
          _this2.errors_general = error.response.data.message;
          console.log(_this2.errors);
        }
      });
    },
    saveSelectedItemId: function saveSelectedItemId() {// Simpan selectedItem.id ke database di sini
      // console.log('Selected item id:', this.mobil.driver);
    }
  }
});

/***/ }),

/***/ "./node_modules/core-js/modules/es.array.filter.js":
/*!*********************************************************!*\
  !*** ./node_modules/core-js/modules/es.array.filter.js ***!
  \*********************************************************/
/***/ (function(__unused_webpack_module, __unused_webpack_exports, __webpack_require__) {


var $ = __webpack_require__(/*! ../internals/export */ "./node_modules/core-js/internals/export.js");
var $filter = (__webpack_require__(/*! ../internals/array-iteration */ "./node_modules/core-js/internals/array-iteration.js").filter);
var arrayMethodHasSpeciesSupport = __webpack_require__(/*! ../internals/array-method-has-species-support */ "./node_modules/core-js/internals/array-method-has-species-support.js");

var HAS_SPECIES_SUPPORT = arrayMethodHasSpeciesSupport('filter');

// `Array.prototype.filter` method
// https://tc39.es/ecma262/#sec-array.prototype.filter
// with adding support of @@species
$({ target: 'Array', proto: true, forced: !HAS_SPECIES_SUPPORT }, {
  filter: function filter(callbackfn /* , thisArg */) {
    return $filter(this, callbackfn, arguments.length > 1 ? arguments[1] : undefined);
  }
});


/***/ }),

/***/ "./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=script&lang=js&":
/*!***********************************************************************************!*\
  !*** ./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=script&lang=js& ***!
  \***********************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_add_mobil_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./add-mobil.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_add_mobil_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=template&id=d4fdcff4&":
/*!*****************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=template&id=d4fdcff4& ***!
  \*****************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_add_mobil_vue_vue_type_template_id_d4fdcff4___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_add_mobil_vue_vue_type_template_id_d4fdcff4___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_add_mobil_vue_vue_type_template_id_d4fdcff4___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./add-mobil.vue?vue&type=template&id=d4fdcff4& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=template&id=d4fdcff4&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=template&id=d4fdcff4&":
/*!********************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=template&id=d4fdcff4& ***!
  \********************************************************************************************************************************************************************************************************************************/
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
    "v-card",
    { staticClass: "ml-3" },
    [
      _c("v-card-title", [_vm._v("Tambah Mobil")]),
      _vm._v(" "),
      _c(
        "v-card-text",
        [
          _c(
            "v-form",
            { staticClass: "bg-light" },
            [
              _c(
                "v-row",
                [
                  _c("v-col", { attrs: { cols: "12", md: "3" } }, [
                    _c("label", { attrs: { for: "firstname" } }, [
                      _vm._v("Nomor Polisi"),
                    ]),
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "9" } },
                    [
                      _c("v-text-field", {
                        attrs: {
                          id: "police_number",
                          outlined: "",
                          dense: "",
                          placeholder: "Nomor Polisi",
                          "error-messages": _vm.errors.police_number,
                        },
                        model: {
                          value: _vm.mobil.police_number,
                          callback: function ($$v) {
                            _vm.$set(_vm.mobil, "police_number", $$v)
                          },
                          expression: "mobil.police_number",
                        },
                      }),
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c("v-col", { attrs: { cols: "12", md: "3" } }, [
                    _c("label", { attrs: { for: "firstname" } }, [
                      _vm._v("Nomor Pintu"),
                    ]),
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "9" } },
                    [
                      _c("v-text-field", {
                        attrs: {
                          id: "nomor_pintu",
                          outlined: "",
                          dense: "",
                          placeholder: "Nomor Pintu",
                          "error-messages": _vm.errors.nomor_pintu,
                        },
                        model: {
                          value: _vm.mobil.nomor_pintu,
                          callback: function ($$v) {
                            _vm.$set(_vm.mobil, "nomor_pintu", $$v)
                          },
                          expression: "mobil.nomor_pintu",
                        },
                      }),
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c("v-col", { attrs: { cols: "12", md: "3" } }, [
                    _c("label", { attrs: { for: "email" } }, [_vm._v("Type")]),
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "9" } },
                    [
                      _c("v-select", {
                        attrs: {
                          items: ["Ekonomi", "Eksekutif"],
                          outlined: "",
                          dense: "",
                          placeholder: "Type",
                          "error-messages": _vm.errors.type,
                        },
                        on: { change: _vm.selectType },
                        model: {
                          value: _vm.mobil.type,
                          callback: function ($$v) {
                            _vm.$set(_vm.mobil, "type", $$v)
                          },
                          expression: "mobil.type",
                        },
                      }),
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c("v-col", { attrs: { cols: "12", md: "3" } }, [
                    _c("label", { attrs: { for: "mobile" } }, [
                      _vm._v("Supir"),
                    ]),
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "9" } },
                    [
                      _c("v-select", {
                        attrs: {
                          items: _vm.supir,
                          "item-value": "id",
                          "item-text": "name",
                          outlined: "",
                          dense: "",
                          placeholder: "Pilih supir",
                          "error-messages": _vm.errors.supir_id,
                        },
                        on: { change: _vm.saveSelectedItemId },
                        model: {
                          value: _vm.mobil.driver,
                          callback: function ($$v) {
                            _vm.$set(_vm.mobil, "driver", $$v)
                          },
                          expression: "mobil.driver",
                        },
                      }),
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c("v-col", { attrs: { cols: "12", md: "3" } }, [
                    _c("label", { attrs: { for: "mobile" } }, [
                      _vm._v("Loket"),
                    ]),
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "9" } },
                    [
                      _c("v-select", {
                        attrs: {
                          items: _vm.loket,
                          "item-value": "id",
                          "item-text": "name",
                          outlined: "",
                          dense: "",
                          placeholder: "Pilih Loket",
                          "error-messages": _vm.errors.loket_id,
                        },
                        on: { change: _vm.saveSelectedItemId },
                        model: {
                          value: _vm.mobil.loket,
                          callback: function ($$v) {
                            _vm.$set(_vm.mobil, "loket", $$v)
                          },
                          expression: "mobil.loket",
                        },
                      }),
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { "offset-md": "3", cols: "12" } },
                    [
                      _c(
                        "v-btn",
                        {
                          attrs: { color: "primary" },
                          on: {
                            click: function ($event) {
                              $event.preventDefault()
                              return _vm.AddMobil.apply(null, arguments)
                            },
                          },
                        },
                        [_vm._v(" Submit ")]
                      ),
                      _vm._v(" "),
                      _c(
                        "v-btn",
                        {
                          staticClass: "mx-2",
                          attrs: { type: "reset", outlined: "" },
                        },
                        [_vm._v(" Reset ")]
                      ),
                    ],
                    1
                  ),
                ],
                1
              ),
            ],
            1
          ),
        ],
        1
      ),
    ],
    1
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./resources/js/src/views/pages/Mobil/add-mobil.vue":
/*!**********************************************************!*\
  !*** ./resources/js/src/views/pages/Mobil/add-mobil.vue ***!
  \**********************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _add_mobil_vue_vue_type_template_id_d4fdcff4___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./add-mobil.vue?vue&type=template&id=d4fdcff4& */ "./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=template&id=d4fdcff4&");
/* harmony import */ var _add_mobil_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./add-mobil.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/Mobil/add-mobil.vue?vue&type=script&lang=js&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! !../../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! !../../../../../../node_modules/vuetify-loader/lib/runtime/installComponents.js */ "./node_modules/vuetify-loader/lib/runtime/installComponents.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var vuetify_lib_components_VBtn__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! vuetify/lib/components/VBtn */ "./node_modules/vuetify/lib/components/VBtn/VBtn.js");
/* harmony import */ var vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! vuetify/lib/components/VCard */ "./node_modules/vuetify/lib/components/VCard/VCard.js");
/* harmony import */ var vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! vuetify/lib/components/VCard */ "./node_modules/vuetify/lib/components/VCard/index.js");
/* harmony import */ var vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! vuetify/lib/components/VGrid */ "./node_modules/vuetify/lib/components/VGrid/VCol.js");
/* harmony import */ var vuetify_lib_components_VForm__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! vuetify/lib/components/VForm */ "./node_modules/vuetify/lib/components/VForm/VForm.js");
/* harmony import */ var vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! vuetify/lib/components/VGrid */ "./node_modules/vuetify/lib/components/VGrid/VRow.js");
/* harmony import */ var vuetify_lib_components_VSelect__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! vuetify/lib/components/VSelect */ "./node_modules/vuetify/lib/components/VSelect/VSelect.js");
/* harmony import */ var vuetify_lib_components_VTextField__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! vuetify/lib/components/VTextField */ "./node_modules/vuetify/lib/components/VTextField/VTextField.js");





/* normalize component */
;
var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _add_mobil_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _add_mobil_vue_vue_type_template_id_d4fdcff4___WEBPACK_IMPORTED_MODULE_0__.render,
  _add_mobil_vue_vue_type_template_id_d4fdcff4___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  null,
  null
  
)

/* vuetify-loader */
;









_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3___default()(component, {VBtn: vuetify_lib_components_VBtn__WEBPACK_IMPORTED_MODULE_4__["default"],VCard: vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_5__["default"],VCardText: vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_6__.VCardText,VCardTitle: vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_6__.VCardTitle,VCol: vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_7__["default"],VForm: vuetify_lib_components_VForm__WEBPACK_IMPORTED_MODULE_8__["default"],VRow: vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_9__["default"],VSelect: vuetify_lib_components_VSelect__WEBPACK_IMPORTED_MODULE_10__["default"],VTextField: vuetify_lib_components_VTextField__WEBPACK_IMPORTED_MODULE_11__["default"]})


/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/Mobil/add-mobil.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ })

}]);