"use strict";
(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_edit-user_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/edit-user.vue?vue&type=script&lang=js&":
/*!*********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/edit-user.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var E_laragon_www_DantobBuss_Application_node_modules_babel_runtime_helpers_esm_asyncToGenerator__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./node_modules/@babel/runtime/helpers/esm/asyncToGenerator */ "./node_modules/@babel/runtime/helpers/esm/asyncToGenerator.js");
/* harmony import */ var _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @babel/runtime/regenerator */ "./node_modules/@babel/runtime/regenerator/index.js");
/* harmony import */ var _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _mdi_js__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @mdi/js */ "./node_modules/@mdi/js/mdi.js");
/* harmony import */ var _vue_composition_api__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @vue/composition-api */ "./node_modules/@vue/composition-api/dist/vue-composition-api.mjs");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! axios */ "./node_modules/axios/index.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_2__);


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
    var isPasswordVisible = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_3__.ref)(false);
    var user = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_3__.ref)({}); // Declare user as a ref

    return {
      user: user,
      isPasswordVisible: isPasswordVisible,
      icons: {
        mdiEyeOutline: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiEyeOutline,
        mdiEyeOffOutline: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiEyeOffOutline,
        mdiAccountOutline: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiAccountOutline,
        mdiEmailOutline: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiEmailOutline,
        mdiCellphone: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiCellphone,
        mdiHumanMaleFemale: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiHumanMaleFemale,
        mdiLockOutline: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiLockOutline,
        mdiMapMarker: _mdi_js__WEBPACK_IMPORTED_MODULE_4__.mdiMapMarker
      }
    };
  },
  methods: {
    updateUser: function updateUser() {
      var _this = this;

      return (0,E_laragon_www_DantobBuss_Application_node_modules_babel_runtime_helpers_esm_asyncToGenerator__WEBPACK_IMPORTED_MODULE_0__["default"])( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_1___default().mark(function _callee() {
        var access_token, id, response;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_1___default().wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                access_token = localStorage.getItem('access_token');
                id = _this.$route.params.id;
                _context.prev = 2;
                _context.next = 5;
                return axios__WEBPACK_IMPORTED_MODULE_2___default().put("/api/user/update/".concat(id), _this.user, {
                  headers: {
                    Authorization: "Bearer ".concat(access_token)
                  }
                });

              case 5:
                response = _context.sent;
                console.log(response.data.data.role_id); // Handle success, show a success message, or perform any other actions.

                if (response.data.data.role_id == 4) {
                  _this.$router.push({
                    name: 'pages-admin-loket'
                  }); // Arahkan ke halaman list admin

                } else if (response.data.data.role_id == 3) {
                  _this.$router.push({
                    name: 'pages-supir'
                  }); // Arahkan ke halaman list supir

                } else if (response.data.data.role_id == 1) {
                  _this.$router.push({
                    name: 'list-admin-kantor'
                  }); // Arahkan ke halaman list brands

                }

                _context.next = 13;
                break;

              case 10:
                _context.prev = 10;
                _context.t0 = _context["catch"](2);
                console.error(_context.t0); // Handle error, show an error message, or perform any other actions.

              case 13:
              case "end":
                return _context.stop();
            }
          }
        }, _callee, null, [[2, 10]]);
      }))();
    }
  },
  mounted: function mounted() {
    var _this2 = this;

    var access_token = localStorage.getItem('access_token');
    var id = this.$route.params.id;
    axios__WEBPACK_IMPORTED_MODULE_2___default().get("/api/user/get/".concat(id), {
      headers: {
        Authorization: "Bearer ".concat(access_token)
      }
    }).then(function (response) {
      _this2.user = response.data.data; // console.log(this.user);
    })["catch"](function (error) {
      console.log(error);
    });
  }
});

/***/ }),

/***/ "./resources/js/src/views/pages/edit-user.vue?vue&type=script&lang=js&":
/*!*****************************************************************************!*\
  !*** ./resources/js/src/views/pages/edit-user.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_edit_user_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./edit-user.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/edit-user.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_edit_user_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/edit-user.vue?vue&type=template&id=1d64ad89&":
/*!***********************************************************************************!*\
  !*** ./resources/js/src/views/pages/edit-user.vue?vue&type=template&id=1d64ad89& ***!
  \***********************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_edit_user_vue_vue_type_template_id_1d64ad89___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_edit_user_vue_vue_type_template_id_1d64ad89___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_edit_user_vue_vue_type_template_id_1d64ad89___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./edit-user.vue?vue&type=template&id=1d64ad89& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/edit-user.vue?vue&type=template&id=1d64ad89&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/edit-user.vue?vue&type=template&id=1d64ad89&":
/*!**************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/edit-user.vue?vue&type=template&id=1d64ad89& ***!
  \**************************************************************************************************************************************************************************************************************************/
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
    "v-card-text",
    [
      _c("h3", {}, [_vm._v("Edit User")]),
      _vm._v(" "),
      _c(
        "v-form",
        [
          _c(
            "v-row",
            [
              _c(
                "v-col",
                { attrs: { cols: "12", md: "6" } },
                [
                  _c("v-text-field", {
                    attrs: {
                      "prepend-inner-icon": _vm.icons.mdiAccountOutline,
                      label: "Nama Lengkap",
                      outlined: "",
                      dense: "",
                      placeholder: "Nama Lengkap",
                    },
                    model: {
                      value: _vm.user.name,
                      callback: function ($$v) {
                        _vm.$set(_vm.user, "name", $$v)
                      },
                      expression: "user.name",
                    },
                  }),
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "v-col",
                { attrs: { cols: "12", md: "6" } },
                [
                  _c("v-text-field", {
                    attrs: {
                      "prepend-inner-icon": _vm.icons.mdiEmailOutline,
                      label: "Email",
                      type: "email",
                      outlined: "",
                      dense: "",
                      placeholder: "Email",
                    },
                    model: {
                      value: _vm.user.email,
                      callback: function ($$v) {
                        _vm.$set(_vm.user, "email", $$v)
                      },
                      expression: "user.email",
                    },
                  }),
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "v-col",
                { attrs: { cols: "12", md: "6" } },
                [
                  _c("v-text-field", {
                    attrs: {
                      "prepend-inner-icon": _vm.icons.mdiAccountOutline,
                      label: "Username",
                      outlined: "",
                      dense: "",
                      placeholder: "Username",
                    },
                    model: {
                      value: _vm.user.username,
                      callback: function ($$v) {
                        _vm.$set(_vm.user, "username", $$v)
                      },
                      expression: "user.username",
                    },
                  }),
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "v-col",
                { attrs: { cols: "12", md: "6" } },
                [
                  _c("v-text-field", {
                    attrs: {
                      "prepend-inner-icon": _vm.icons.mdiCellphone,
                      label: "Nomor Handphone",
                      outlined: "",
                      dense: "",
                      type: "number",
                      placeholder: "Nomor Handphone",
                    },
                    model: {
                      value: _vm.user.phone_number,
                      callback: function ($$v) {
                        _vm.$set(_vm.user, "phone_number", $$v)
                      },
                      expression: "user.phone_number",
                    },
                  }),
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "v-col",
                { attrs: { cols: "12", md: "6" } },
                [
                  _c("v-select", {
                    attrs: {
                      items: ["Laki-laki", "Perempuan"],
                      "prepend-inner-icon": _vm.icons.mdiHumanMaleFemale,
                      label: "Jenis Kelamin",
                      outlined: "",
                      dense: "",
                      placeholder: "Jenis Kelamin",
                    },
                    model: {
                      value: _vm.user.gender,
                      callback: function ($$v) {
                        _vm.$set(_vm.user, "gender", $$v)
                      },
                      expression: "user.gender",
                    },
                  }),
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "v-col",
                { attrs: { cols: "12", md: "6" } },
                [
                  _c("v-text-field", {
                    attrs: {
                      "prepend-inner-icon": _vm.icons.mdiMapMarker,
                      label: "Alamat",
                      outlined: "",
                      dense: "",
                      type: "text",
                      placeholder: "Alamat",
                    },
                    model: {
                      value: _vm.user.address,
                      callback: function ($$v) {
                        _vm.$set(_vm.user, "address", $$v)
                      },
                      expression: "user.address",
                    },
                  }),
                ],
                1
              ),
            ],
            1
          ),
          _vm._v(" "),
          _c(
            "v-col",
            { staticClass: "align-center", attrs: { cols: "3" } },
            [
              _c(
                "v-btn",
                {
                  staticClass: "mt-6",
                  attrs: { color: "primary" },
                  on: {
                    click: function ($event) {
                      $event.preventDefault()
                      return _vm.updateUser.apply(null, arguments)
                    },
                  },
                },
                [_vm._v("Update")]
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

/***/ "./resources/js/src/views/pages/edit-user.vue":
/*!****************************************************!*\
  !*** ./resources/js/src/views/pages/edit-user.vue ***!
  \****************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _edit_user_vue_vue_type_template_id_1d64ad89___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./edit-user.vue?vue&type=template&id=1d64ad89& */ "./resources/js/src/views/pages/edit-user.vue?vue&type=template&id=1d64ad89&");
/* harmony import */ var _edit_user_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./edit-user.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/edit-user.vue?vue&type=script&lang=js&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! !../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! !../../../../../node_modules/vuetify-loader/lib/runtime/installComponents.js */ "./node_modules/vuetify-loader/lib/runtime/installComponents.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var vuetify_lib_components_VBtn__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! vuetify/lib/components/VBtn */ "./node_modules/vuetify/lib/components/VBtn/VBtn.js");
/* harmony import */ var vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! vuetify/lib/components/VCard */ "./node_modules/vuetify/lib/components/VCard/index.js");
/* harmony import */ var vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! vuetify/lib/components/VGrid */ "./node_modules/vuetify/lib/components/VGrid/VCol.js");
/* harmony import */ var vuetify_lib_components_VForm__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! vuetify/lib/components/VForm */ "./node_modules/vuetify/lib/components/VForm/VForm.js");
/* harmony import */ var vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! vuetify/lib/components/VGrid */ "./node_modules/vuetify/lib/components/VGrid/VRow.js");
/* harmony import */ var vuetify_lib_components_VSelect__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! vuetify/lib/components/VSelect */ "./node_modules/vuetify/lib/components/VSelect/VSelect.js");
/* harmony import */ var vuetify_lib_components_VTextField__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! vuetify/lib/components/VTextField */ "./node_modules/vuetify/lib/components/VTextField/VTextField.js");





/* normalize component */
;
var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _edit_user_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _edit_user_vue_vue_type_template_id_1d64ad89___WEBPACK_IMPORTED_MODULE_0__.render,
  _edit_user_vue_vue_type_template_id_1d64ad89___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  null,
  null
  
)

/* vuetify-loader */
;







_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_3___default()(component, {VBtn: vuetify_lib_components_VBtn__WEBPACK_IMPORTED_MODULE_4__["default"],VCardText: vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_5__.VCardText,VCol: vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_6__["default"],VForm: vuetify_lib_components_VForm__WEBPACK_IMPORTED_MODULE_7__["default"],VRow: vuetify_lib_components_VGrid__WEBPACK_IMPORTED_MODULE_8__["default"],VSelect: vuetify_lib_components_VSelect__WEBPACK_IMPORTED_MODULE_9__["default"],VTextField: vuetify_lib_components_VTextField__WEBPACK_IMPORTED_MODULE_10__["default"]})


/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/edit-user.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ })

}]);