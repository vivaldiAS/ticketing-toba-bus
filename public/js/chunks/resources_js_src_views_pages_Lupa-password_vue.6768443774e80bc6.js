(self["webpackChunkDantobBuss_Application"] = self["webpackChunkDantobBuss_Application"] || []).push([["resources_js_src_views_pages_Lupa-password_vue"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=script&lang=js&":
/*!*************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=script&lang=js& ***!
  \*************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var core_js_modules_es_array_join_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! core-js/modules/es.array.join.js */ "./node_modules/core-js/modules/es.array.join.js");
/* harmony import */ var core_js_modules_es_array_join_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_join_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var core_js_modules_es_array_concat_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! core-js/modules/es.array.concat.js */ "./node_modules/core-js/modules/es.array.concat.js");
/* harmony import */ var core_js_modules_es_array_concat_js__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_array_concat_js__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var core_js_modules_es_string_pad_start_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! core-js/modules/es.string.pad-start.js */ "./node_modules/core-js/modules/es.string.pad-start.js");
/* harmony import */ var core_js_modules_es_string_pad_start_js__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_string_pad_start_js__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! core-js/modules/es.object.to-string.js */ "./node_modules/core-js/modules/es.object.to-string.js");
/* harmony import */ var core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var core_js_modules_es_regexp_to_string_js__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! core-js/modules/es.regexp.to-string.js */ "./node_modules/core-js/modules/es.regexp.to-string.js");
/* harmony import */ var core_js_modules_es_regexp_to_string_js__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(core_js_modules_es_regexp_to_string_js__WEBPACK_IMPORTED_MODULE_4__);
/* harmony import */ var _vue_composition_api__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! @vue/composition-api */ "./node_modules/@vue/composition-api/dist/vue-composition-api.mjs");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! axios */ "./node_modules/axios/index.js");
/* harmony import */ var axios__WEBPACK_IMPORTED_MODULE_5___default = /*#__PURE__*/__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_5__);
/* harmony import */ var sweetalert2__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! sweetalert2 */ "./node_modules/sweetalert2/dist/sweetalert2.all.js");
/* harmony import */ var sweetalert2__WEBPACK_IMPORTED_MODULE_6___default = /*#__PURE__*/__webpack_require__.n(sweetalert2__WEBPACK_IMPORTED_MODULE_6__);
/* harmony import */ var vue_otp_2__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! vue-otp-2 */ "./node_modules/vue-otp-2/dist/vue-otp-2.esm.js");





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
  components: {
    VueOtp2: vue_otp_2__WEBPACK_IMPORTED_MODULE_7__["default"]
  },
  setup: function setup() {
    var email = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_8__.ref)("");
    var otpCode = (0,_vue_composition_api__WEBPACK_IMPORTED_MODULE_8__.ref)("");
    return {
      email: email,
      otpCode: otpCode,
      isOTP: false,
      countdown: "01:00",
      // Initial countdown time in mm:ss format
      isResending: false,
      // Flag to indicate if the OTP is currently being resent
      timer: null // Variable to store the timer ID

    };
  },
  data: function data() {
    return {
      email: "",
      errors: {},
      isLoading: false
    };
  },
  mounted: function mounted() {
    this.startCountdown();
  },
  methods: {
    submitEmail: function submitEmail() {
      var _this = this;

      this.isLoading = true;
      axios__WEBPACK_IMPORTED_MODULE_5___default().post("api/reset-password", {
        email: this.email
      }).then(function (response) {
        //Check email if registered
        console.log(response.data.message);
        console.log(_this.otpCode);
        sweetalert2__WEBPACK_IMPORTED_MODULE_6___default().fire({
          icon: "success",
          title: "Berhasil",
          text: "Berhasil mengirimkan OTP ",
          confirmButtonText: "Ok",
          confirmButtonColor: "#d33"
        });
        _this.isLoading = false;
        _this.isOTP = true;
      })["catch"](function (error) {
        if (error.response.status === 422) {
          _this.errors = error.response.data.data;
          _this.errors_general = error.response.data.message;
          console.log(_this.errors);
        }

        sweetalert2__WEBPACK_IMPORTED_MODULE_6___default().fire({
          icon: "error",
          title: "Gagal",
          text: _this.errors,
          confirmButtonText: "Ok",
          confirmButtonColor: "#d33"
        });
        _this.isLoading = false;
        _this.isOTP = false;
        sweetalert2__WEBPACK_IMPORTED_MODULE_6___default().fire({
          icon: "error",
          title: "Gagal",
          text: "Email tidak terdaftar",
          confirmButtonText: "Ok",
          confirmButtonColor: "#d33"
        });
        _this.isLoading = false;
      });
    },
    submitAgain: function submitAgain() {
      var _this2 = this;

      axios__WEBPACK_IMPORTED_MODULE_5___default().post("api/reset-password", {
        email: this.email
      }).then(function (response) {
        //Check email if registered
        console.log(response.data.message);
        console.log(_this2.otpCode);
        sweetalert2__WEBPACK_IMPORTED_MODULE_6___default().fire({
          icon: "success",
          title: "Berhasil",
          text: "Berhasil mengirimkan OTP ",
          confirmButtonText: "Ok",
          confirmButtonColor: "#d33"
        });
      });
      this.startCountdown();
    },
    back: function back() {
      this.isOTP = false;
    },
    onOtpInput: function onOtpInput(value) {
      var enteredOtpValueArray = this.$refs.otpInput.otp;
      var enteredOtpValue = enteredOtpValueArray.join("");
      console.log("Entered OTP:", enteredOtpValue);
      this.otpCode = enteredOtpValue;

      if (this.otpCode.length === 4) {
        this.submitOtp();
      }
    },
    submitOtp: function submitOtp() {
      var _this3 = this;

      axios__WEBPACK_IMPORTED_MODULE_5___default().post("api/getOtp", {
        email: this.email,
        otp: this.otpCode
      }).then(function (response) {
        _this3.msg = response.data;
        console.log(_this3.msg);
        sweetalert2__WEBPACK_IMPORTED_MODULE_6___default().fire({
          icon: "success",
          title: "Berhasil",
          text: "OTP sesuai.",
          confirmButtonText: "Ok",
          confirmButtonColor: "#307475"
        });

        _this3.$router.push("/reset-password/".concat(_this3.email));
      })["catch"](function (error) {
        if (error.response.status === 422) {
          _this3.errors = error.response.data.data;
          _this3.errors_general = error.response.data.message;
          console.log(_this3.errors);
        }

        sweetalert2__WEBPACK_IMPORTED_MODULE_6___default().fire({
          icon: "error",
          title: "Gagal",
          text: _this3.errors_general,
          confirmButtonText: "Ok",
          confirmButtonColor: "#d33"
        });
        console.log(error);
      });
    },
    resendOTP: function resendOTP() {
      this.startCountdown();
    },
    startCountdown: function startCountdown() {
      var _this4 = this;

      var remainingSeconds = 60; // Set the initial number of seconds for the countdown

      this.isResending = true; // Set the flag to true to show the "Tunggu sebentar..." message

      this.timer = setInterval(function () {
        var minutes = Math.floor(remainingSeconds / 60);
        var seconds = remainingSeconds % 60;
        _this4.countdown = "".concat(minutes.toString().padStart(2, "0"), ":").concat(seconds.toString().padStart(2, "0"));
        remainingSeconds--;

        if (remainingSeconds < 0) {
          _this4.stopCountdown();
        }
      }, 1000);
    },
    stopCountdown: function stopCountdown() {
      clearInterval(this.timer);
      this.countdown = "00:00"; // Set the countdown to 00:00 when the timer is stopped

      this.isResending = false; // Set the flag to false to show the "Kirim ulang" link again
    }
  }
});

/***/ }),

/***/ "./node_modules/core-js/internals/array-method-is-strict.js":
/*!******************************************************************!*\
  !*** ./node_modules/core-js/internals/array-method-is-strict.js ***!
  \******************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";

var fails = __webpack_require__(/*! ../internals/fails */ "./node_modules/core-js/internals/fails.js");

module.exports = function (METHOD_NAME, argument) {
  var method = [][METHOD_NAME];
  return !!method && fails(function () {
    // eslint-disable-next-line no-useless-call,no-throw-literal -- required for testing
    method.call(null, argument || function () { throw 1; }, 1);
  });
};


/***/ }),

/***/ "./node_modules/core-js/internals/regexp-flags.js":
/*!********************************************************!*\
  !*** ./node_modules/core-js/internals/regexp-flags.js ***!
  \********************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";

var anObject = __webpack_require__(/*! ../internals/an-object */ "./node_modules/core-js/internals/an-object.js");

// `RegExp.prototype.flags` getter implementation
// https://tc39.es/ecma262/#sec-get-regexp.prototype.flags
module.exports = function () {
  var that = anObject(this);
  var result = '';
  if (that.global) result += 'g';
  if (that.ignoreCase) result += 'i';
  if (that.multiline) result += 'm';
  if (that.dotAll) result += 's';
  if (that.unicode) result += 'u';
  if (that.sticky) result += 'y';
  return result;
};


/***/ }),

/***/ "./node_modules/core-js/internals/string-pad-webkit-bug.js":
/*!*****************************************************************!*\
  !*** ./node_modules/core-js/internals/string-pad-webkit-bug.js ***!
  \*****************************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

// https://github.com/zloirock/core-js/issues/280
var userAgent = __webpack_require__(/*! ../internals/engine-user-agent */ "./node_modules/core-js/internals/engine-user-agent.js");

module.exports = /Version\/10(?:\.\d+){1,2}(?: [\w./]+)?(?: Mobile\/\w+)? Safari\//.test(userAgent);


/***/ }),

/***/ "./node_modules/core-js/internals/string-pad.js":
/*!******************************************************!*\
  !*** ./node_modules/core-js/internals/string-pad.js ***!
  \******************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

// https://github.com/tc39/proposal-string-pad-start-end
var uncurryThis = __webpack_require__(/*! ../internals/function-uncurry-this */ "./node_modules/core-js/internals/function-uncurry-this.js");
var toLength = __webpack_require__(/*! ../internals/to-length */ "./node_modules/core-js/internals/to-length.js");
var toString = __webpack_require__(/*! ../internals/to-string */ "./node_modules/core-js/internals/to-string.js");
var $repeat = __webpack_require__(/*! ../internals/string-repeat */ "./node_modules/core-js/internals/string-repeat.js");
var requireObjectCoercible = __webpack_require__(/*! ../internals/require-object-coercible */ "./node_modules/core-js/internals/require-object-coercible.js");

var repeat = uncurryThis($repeat);
var stringSlice = uncurryThis(''.slice);
var ceil = Math.ceil;

// `String.prototype.{ padStart, padEnd }` methods implementation
var createMethod = function (IS_END) {
  return function ($this, maxLength, fillString) {
    var S = toString(requireObjectCoercible($this));
    var intMaxLength = toLength(maxLength);
    var stringLength = S.length;
    var fillStr = fillString === undefined ? ' ' : toString(fillString);
    var fillLen, stringFiller;
    if (intMaxLength <= stringLength || fillStr == '') return S;
    fillLen = intMaxLength - stringLength;
    stringFiller = repeat(fillStr, ceil(fillLen / fillStr.length));
    if (stringFiller.length > fillLen) stringFiller = stringSlice(stringFiller, 0, fillLen);
    return IS_END ? S + stringFiller : stringFiller + S;
  };
};

module.exports = {
  // `String.prototype.padStart` method
  // https://tc39.es/ecma262/#sec-string.prototype.padstart
  start: createMethod(false),
  // `String.prototype.padEnd` method
  // https://tc39.es/ecma262/#sec-string.prototype.padend
  end: createMethod(true)
};


/***/ }),

/***/ "./node_modules/core-js/internals/string-repeat.js":
/*!*********************************************************!*\
  !*** ./node_modules/core-js/internals/string-repeat.js ***!
  \*********************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

"use strict";

var global = __webpack_require__(/*! ../internals/global */ "./node_modules/core-js/internals/global.js");
var toIntegerOrInfinity = __webpack_require__(/*! ../internals/to-integer-or-infinity */ "./node_modules/core-js/internals/to-integer-or-infinity.js");
var toString = __webpack_require__(/*! ../internals/to-string */ "./node_modules/core-js/internals/to-string.js");
var requireObjectCoercible = __webpack_require__(/*! ../internals/require-object-coercible */ "./node_modules/core-js/internals/require-object-coercible.js");

var RangeError = global.RangeError;

// `String.prototype.repeat` method implementation
// https://tc39.es/ecma262/#sec-string.prototype.repeat
module.exports = function repeat(count) {
  var str = toString(requireObjectCoercible(this));
  var result = '';
  var n = toIntegerOrInfinity(count);
  if (n < 0 || n == Infinity) throw RangeError('Wrong number of repetitions');
  for (;n > 0; (n >>>= 1) && (str += str)) if (n & 1) result += str;
  return result;
};


/***/ }),

/***/ "./node_modules/core-js/modules/es.array.join.js":
/*!*******************************************************!*\
  !*** ./node_modules/core-js/modules/es.array.join.js ***!
  \*******************************************************/
/***/ (function(__unused_webpack_module, __unused_webpack_exports, __webpack_require__) {

"use strict";

var $ = __webpack_require__(/*! ../internals/export */ "./node_modules/core-js/internals/export.js");
var uncurryThis = __webpack_require__(/*! ../internals/function-uncurry-this */ "./node_modules/core-js/internals/function-uncurry-this.js");
var IndexedObject = __webpack_require__(/*! ../internals/indexed-object */ "./node_modules/core-js/internals/indexed-object.js");
var toIndexedObject = __webpack_require__(/*! ../internals/to-indexed-object */ "./node_modules/core-js/internals/to-indexed-object.js");
var arrayMethodIsStrict = __webpack_require__(/*! ../internals/array-method-is-strict */ "./node_modules/core-js/internals/array-method-is-strict.js");

var un$Join = uncurryThis([].join);

var ES3_STRINGS = IndexedObject != Object;
var STRICT_METHOD = arrayMethodIsStrict('join', ',');

// `Array.prototype.join` method
// https://tc39.es/ecma262/#sec-array.prototype.join
$({ target: 'Array', proto: true, forced: ES3_STRINGS || !STRICT_METHOD }, {
  join: function join(separator) {
    return un$Join(toIndexedObject(this), separator === undefined ? ',' : separator);
  }
});


/***/ }),

/***/ "./node_modules/core-js/modules/es.regexp.to-string.js":
/*!*************************************************************!*\
  !*** ./node_modules/core-js/modules/es.regexp.to-string.js ***!
  \*************************************************************/
/***/ (function(__unused_webpack_module, __unused_webpack_exports, __webpack_require__) {

"use strict";

var uncurryThis = __webpack_require__(/*! ../internals/function-uncurry-this */ "./node_modules/core-js/internals/function-uncurry-this.js");
var PROPER_FUNCTION_NAME = (__webpack_require__(/*! ../internals/function-name */ "./node_modules/core-js/internals/function-name.js").PROPER);
var redefine = __webpack_require__(/*! ../internals/redefine */ "./node_modules/core-js/internals/redefine.js");
var anObject = __webpack_require__(/*! ../internals/an-object */ "./node_modules/core-js/internals/an-object.js");
var isPrototypeOf = __webpack_require__(/*! ../internals/object-is-prototype-of */ "./node_modules/core-js/internals/object-is-prototype-of.js");
var $toString = __webpack_require__(/*! ../internals/to-string */ "./node_modules/core-js/internals/to-string.js");
var fails = __webpack_require__(/*! ../internals/fails */ "./node_modules/core-js/internals/fails.js");
var regExpFlags = __webpack_require__(/*! ../internals/regexp-flags */ "./node_modules/core-js/internals/regexp-flags.js");

var TO_STRING = 'toString';
var RegExpPrototype = RegExp.prototype;
var n$ToString = RegExpPrototype[TO_STRING];
var getFlags = uncurryThis(regExpFlags);

var NOT_GENERIC = fails(function () { return n$ToString.call({ source: 'a', flags: 'b' }) != '/a/b'; });
// FF44- RegExp#toString has a wrong name
var INCORRECT_NAME = PROPER_FUNCTION_NAME && n$ToString.name != TO_STRING;

// `RegExp.prototype.toString` method
// https://tc39.es/ecma262/#sec-regexp.prototype.tostring
if (NOT_GENERIC || INCORRECT_NAME) {
  redefine(RegExp.prototype, TO_STRING, function toString() {
    var R = anObject(this);
    var p = $toString(R.source);
    var rf = R.flags;
    var f = $toString(rf === undefined && isPrototypeOf(RegExpPrototype, R) && !('flags' in RegExpPrototype) ? getFlags(R) : rf);
    return '/' + p + '/' + f;
  }, { unsafe: true });
}


/***/ }),

/***/ "./node_modules/core-js/modules/es.string.pad-start.js":
/*!*************************************************************!*\
  !*** ./node_modules/core-js/modules/es.string.pad-start.js ***!
  \*************************************************************/
/***/ (function(__unused_webpack_module, __unused_webpack_exports, __webpack_require__) {

"use strict";

var $ = __webpack_require__(/*! ../internals/export */ "./node_modules/core-js/internals/export.js");
var $padStart = (__webpack_require__(/*! ../internals/string-pad */ "./node_modules/core-js/internals/string-pad.js").start);
var WEBKIT_BUG = __webpack_require__(/*! ../internals/string-pad-webkit-bug */ "./node_modules/core-js/internals/string-pad-webkit-bug.js");

// `String.prototype.padStart` method
// https://tc39.es/ecma262/#sec-string.prototype.padstart
$({ target: 'String', proto: true, forced: WEBKIT_BUG }, {
  padStart: function padStart(maxLength /* , fillString = ' ' */) {
    return $padStart(this, maxLength, arguments.length > 1 ? arguments[1] : undefined);
  }
});


/***/ }),

/***/ "./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true&":
/*!******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true& ***!
  \******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../../../../node_modules/laravel-mix/node_modules/css-loader/dist/runtime/api.js */ "./node_modules/laravel-mix/node_modules/css-loader/dist/runtime/api.js");
/* harmony import */ var _node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__);
// Imports

var ___CSS_LOADER_EXPORT___ = _node_modules_laravel_mix_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default()(function(i){return i[1]});
// Module
___CSS_LOADER_EXPORT___.push([module.id, ".auth-wrapper[data-v-c3f85fee] {\n  display: flex;\n  min-height: calc(var(--vh, 1vh) * 100);\n  width: 100%;\n  flex-basis: 100%;\n  align-items: center;\n}\n.auth-wrapper a[data-v-c3f85fee] {\n  text-decoration: unset;\n}\n.auth-wrapper.auth-v1[data-v-c3f85fee] {\n  align-items: center;\n  justify-content: center;\n  overflow: hidden;\n  padding: 1.5rem;\n}\n.auth-wrapper.auth-v1 .auth-mask-bg[data-v-c3f85fee] {\n  position: absolute;\n  bottom: 0;\n  width: 100%;\n}\n.auth-wrapper.auth-v1 .auth-tree[data-v-c3f85fee],\n.auth-wrapper.auth-v1 .auth-tree-3[data-v-c3f85fee] {\n  position: absolute;\n}\n.auth-wrapper.auth-v1 .auth-tree[data-v-c3f85fee] {\n  bottom: 0;\n  left: 0;\n}\n.auth-wrapper.auth-v1 .auth-tree-3[data-v-c3f85fee] {\n  bottom: 0;\n  right: 0;\n}\n.auth-wrapper.auth-v1 .auth-inner[data-v-c3f85fee] {\n  width: 35rem;\n  z-index: 1;\n}\n.auth-wrapper.auth-v1 .auth-inner .auth-card[data-v-c3f85fee] {\n  padding: 0.9375rem 0.875rem;\n}\n@media (max-width: 600px) {\n.auth-v1 .auth-tree[data-v-c3f85fee],\n.auth-v1 .auth-tree-3[data-v-c3f85fee],\n.auth-v1 .auth-mask-bg[data-v-c3f85fee] {\n    display: none;\n}\n}\n.body1[data-v-c3f85fee] {\n  padding: 40px;\n}\n.judul[data-v-c3f85fee] {\n  margin-bottom: 40px;\n  text-align: center;\n}\n.body[data-v-c3f85fee] {\n  margin-bottom: 40px;\n  text-align: center;\n}\n.btn-kirim[data-v-c3f85fee] {\n  width: 50%;\n  text-align: center;\n  margin-top: 20px;\n  margin-bottom: 30px;\n}\n.otp-input[data-v-c3f85fee] {\n  width: 40px;\n  height: 40px;\n  padding: 5px;\n  margin: 0 10px;\n  font-size: 20px;\n  border-radius: 4px;\n  border: 1px solid rgba(0, 0, 0, 0.3);\n  text-align: center;\n}\n.otp-input.error[data-v-c3f85fee] {\n  border: 1px solid red !important;\n}\n.otp-input[data-v-c3f85fee]::-webkit-inner-spin-button,\n.otp-input[data-v-c3f85fee]::-webkit-outer-spin-button {\n  -webkit-appearance: none;\n  margin: 0;\n}", ""]);
// Exports
/* harmony default export */ __webpack_exports__["default"] = (___CSS_LOADER_EXPORT___);


/***/ }),

/***/ "./node_modules/style-loader/dist/cjs.js!./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true&":
/*!**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/style-loader/dist/cjs.js!./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true& ***!
  \**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! !../../../../../node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js");
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_style_index_0_id_c3f85fee_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! !!../../../../../node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!../../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../../node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!../../../../../node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true& */ "./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true&");

            

var options = {};

options.insert = "head";
options.singleton = false;

var update = _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default()(_node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_style_index_0_id_c3f85fee_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_1__["default"], options);



/* harmony default export */ __webpack_exports__["default"] = (_node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_style_index_0_id_c3f85fee_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_1__["default"].locals || {});

/***/ }),

/***/ "./resources/js/src/views/pages/Lupa-password.vue?vue&type=script&lang=js&":
/*!*********************************************************************************!*\
  !*** ./resources/js/src/views/pages/Lupa-password.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./Lupa-password.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true&":
/*!******************************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true& ***!
  \******************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_cjs_js_node_modules_laravel_mix_node_modules_css_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_laravel_mix_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_11_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_style_index_0_id_c3f85fee_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/style-loader/dist/cjs.js!../../../../../node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!../../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../../node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!../../../../../node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true& */ "./node_modules/style-loader/dist/cjs.js!./node_modules/laravel-mix/node_modules/css-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/laravel-mix/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-11[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true&");


/***/ }),

/***/ "./resources/js/src/views/pages/Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true&":
/*!***************************************************************************************************!*\
  !*** ./resources/js/src/views/pages/Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true& ***!
  \***************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_template_id_c3f85fee_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_template_id_c3f85fee_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_Lupa_password_vue_vue_type_template_id_c3f85fee_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true&":
/*!******************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/src/views/pages/Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true& ***!
  \******************************************************************************************************************************************************************************************************************************************/
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
  return _c("div", { staticClass: "auth-wrapper auth-v1" }, [
    _c(
      "div",
      { staticClass: "auth-inner" },
      [
        _c(
          "v-card",
          { staticClass: "auth-card" },
          [
            _vm.isOTP
              ? _c("v-form", { ref: "form" }, [
                  _c("div", { staticClass: "body1" }, [
                    _c(
                      "h3",
                      { staticClass: "judul", attrs: { color: "primary" } },
                      [_vm._v("Masukkan Kode 4 Digit")]
                    ),
                    _vm._v(" "),
                    _c("p", { staticClass: "body" }, [
                      _vm._v(
                        "\n            Masukkan 4 digit kode verifikasi yang dikirim ke email terdaftar Anda.\n          "
                      ),
                    ]),
                    _vm._v(" "),
                    _c(
                      "div",
                      { staticClass: "otp-container" },
                      [
                        _c("vue-otp2", {
                          ref: "otpInput",
                          attrs: {
                            length: 4,
                            "input-style": {
                              width: "30px",
                              height: "50px",
                              borderRadius: "4px",
                              textAlign: "center",
                              fontSize: "18px",
                            },
                          },
                          on: { onComplete: _vm.onOtpInput },
                        }),
                      ],
                      1
                    ),
                    _vm._v(" "),
                    _c("div", { staticClass: "text-center mt-3" }, [
                      !_vm.isResending
                        ? _c("span", [
                            _vm._v(
                              "\n              Tidak menerima OTP?\n              "
                            ),
                            _c(
                              "span",
                              {
                                staticStyle: { "font-weight": "bold" },
                                attrs: { color: "primary" },
                                on: { click: _vm.submitAgain },
                              },
                              [_vm._v("Kirim ulang")]
                            ),
                            _vm._v(" "),
                            _vm.countdown !== "00:00"
                              ? _c("span", [
                                  _vm._v("(" + _vm._s(_vm.countdown) + ")"),
                                ])
                              : _vm._e(),
                          ])
                        : _c("span", { staticStyle: { color: "#ff4c51" } }, [
                            _vm._v("\n              Kirim ulang dalam "),
                            _c("span", [_vm._v(_vm._s(_vm.countdown))]),
                          ]),
                    ]),
                    _vm._v(" "),
                    _c(
                      "p",
                      {
                        staticClass: "text-center",
                        attrs: { color: "info" },
                        on: { click: _vm.back },
                      },
                      [_vm._v("Kembali")]
                    ),
                  ]),
                ])
              : _c(
                  "v-form",
                  {
                    ref: "form",
                    on: {
                      submit: function ($event) {
                        $event.preventDefault()
                        return _vm.submitEmail.apply(null, arguments)
                      },
                    },
                  },
                  [
                    _c(
                      "div",
                      { staticClass: "body1" },
                      [
                        _c(
                          "h3",
                          { staticClass: "judul", attrs: { color: "primary" } },
                          [_vm._v("Lupa Password")]
                        ),
                        _vm._v(" "),
                        _c("p", { staticClass: "body" }, [
                          _vm._v(
                            "\n            Masukkan alamat email yang terkait dengan akun Anda dan kami akan\n            mengirimkan tautan untuk mengatur ulang kata sandi Anda\n          "
                          ),
                        ]),
                        _vm._v(" "),
                        _c("v-text-field", {
                          staticClass: "mb-1",
                          attrs: {
                            outlined: "",
                            label: "Email",
                            placeholder: "john@example.com",
                            "error-messages": _vm.errors.email,
                          },
                          model: {
                            value: _vm.email,
                            callback: function ($$v) {
                              _vm.email = $$v
                            },
                            expression: "email",
                          },
                        }),
                        _vm._v(" "),
                        _c(
                          "center",
                          [
                            _c(
                              "v-btn",
                              {
                                staticClass: "mt-6 btn-kirim",
                                attrs: {
                                  type: "submit",
                                  color: "primary",
                                  loading: _vm.isLoading,
                                },
                              },
                              [
                                !_vm.isLoading ? [_vm._v(" Kirim ")] : _vm._e(),
                                _vm._v(" "),
                                _vm.isLoading
                                  ? [
                                      _c("v-progress-circular", {
                                        attrs: {
                                          indeterminate: "",
                                          size: "24",
                                          color: "white",
                                        },
                                      }),
                                    ]
                                  : _vm._e(),
                              ],
                              2
                            ),
                          ],
                          1
                        ),
                      ],
                      1
                    ),
                  ]
                ),
          ],
          1
        ),
      ],
      1
    ),
  ])
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./node_modules/vue-otp-2/dist/vue-otp-2.esm.js":
/*!******************************************************!*\
  !*** ./node_modules/vue-otp-2/dist/vue-otp-2.esm.js ***!
  \******************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
const ON_INPUT_COMPLETE_EVENT = "onComplete";
const ON_INPUT_CHANGE_EVENT = "onChange";
var script = {
  name: "VueOtp2",
  props: ["length", "joinCharacter", "inputmode", "pattern"],
  data: function () {
    return {
      otpLength: +this.length || 6,
      inputMode: this.inputmode || "numeric",
      inputPattern: this.pattern || "[0-9]*",
      character: this.joinCharacter,
      otp: [],
      currentInputCursorIndex: 0,
      inputRefs: [],
      isDeleteKey: false // emulator delete key

    };
  },

  mounted() {
    this.initInputRefs(this.otpLength);
    this.initOtpLength(this.otpLength);
  },

  computed: {
    currentOtpLength() {
      return this.otp.filter(item => item).length;
    }

  },
  methods: {
    handleInput(e) {
      // fix samsung keyboard with keyCode on press not working normally
      const keyData = e.data;
      const keyCode = keyData ? keyData.charCodeAt(0) : 0;
      return this.isDeletePress(keyCode) ? this.onDelete() : this.onType(keyData);
    },

    handleKeyup() {
      if (this.isDeleteKey) {
        this.prevInput();
      }

      this.riseChangeIsDeleteKey(true);
    },

    isDeletePress(keyCode) {
      return keyCode === 0;
    },

    onType(keyData) {
      this.clearSoftAfterInput(this.currentInputCursorIndex);
      this.riseChangeOtp(this.currentInputCursorIndex, keyData);
      this.fillInputValue(this.currentInputCursorIndex, this.otp[this.currentInputCursorIndex]); // continue if input has value

      this.getInputValue(this.currentInputCursorIndex) && this.nextInput();
      this.riseChangeIsDeleteKey(false);
    },

    onDelete() {
      // this.otp[this.currentInputCursorIndex]
      //   ? this.removeInputValue(this.inputRefs[this.currentInputCursorIndex])
      //   : this.prevInput();
      if (this.otp[this.currentInputCursorIndex]) {
        this.removeInputValue(this.inputRefs[this.currentInputCursorIndex]);
      } else {
        this.prevInput();
        this.riseChangeIsDeleteKey(true);
      } // if press delete, delete all after input


      this.clearSoftAfterInput(this.currentInputCursorIndex);
    },

    riseChangeOtp(index, data) {
      this.otp.splice(index, 1, data);
    },

    riseChangeIsDeleteKey(data) {
      this.isDeleteKey = !!data;
    },

    handleFocus(e, i) {
      e.target.select();
      const inputFilled = this.otp.filter(item => item).length;
      this.currentInputCursorIndex = i > inputFilled ? inputFilled : i;
      this.focusInput(this.inputRefs[this.currentInputCursorIndex]);
    },

    initInputRefs(inputNums) {
      let i = 0;

      while (i < inputNums) {
        this.inputRefs = [...this.inputRefs, this.$refs[`input${i}`]];
        i++;
      }
    },

    initOtpLength(length) {
      let i = 0;

      while (i < length) {
        this.otp = [...this.otp, null];
        i++;
      }
    },

    changeInputCursor(idx) {
      this.currentInputCursorIndex = idx;
    },

    nextInputCursor(currentIdx) {
      const index = currentIdx < this.otpLength - 1 ? currentIdx + 1 : this.otpLength - 1;
      this.changeInputCursor(index);
    },

    prevInputCursor(currentIdx) {
      const index = currentIdx > 0 ? currentIdx - 1 : 0;
      this.changeInputCursor(index);
    },

    nextInput() {
      this.nextInputCursor(this.currentInputCursorIndex);
      this.focusInput(this.inputRefs[this.currentInputCursorIndex]);
    },

    prevInput() {
      this.prevInputCursor(this.currentInputCursorIndex);
      this.focusInput(this.inputRefs[this.currentInputCursorIndex]);
    },

    focusInput(inputRefs) {
      inputRefs && inputRefs[0] && inputRefs[0].focus();
    },

    blurInput(inputRefs) {
      inputRefs && inputRefs[0] && inputRefs[0].blur();
    },

    removeInputValue(inputRefs) {
      inputRefs && inputRefs[0] && (() => inputRefs[0].value = null)();
    },

    getInputValue(idx) {
      return this.inputRefs[idx] && this.inputRefs[idx][0] && this.inputRefs[idx][0].value;
    },

    fillInputValue(idx, value) {
      if (this.inputRefs[idx] && this.inputRefs[idx][0]) {
        this.inputRefs[idx][0].value = value;
      }
    },

    validKeyCode(code) {
      const isLetter = code >= 65 && code <= 90;
      const isLowercaseLetter = code >= 97 && code <= 122;
      const isNumber = code >= 48 && code <= 57;
      const isDelete = code === 0;
      return isNumber || isLetter || isLowercaseLetter || isDelete;
    },

    clearAfterInput(idx) {
      this.otp.splice(idx, this.otpLength - idx, ...Array(this.otpLength - idx).fill(null));

      while (idx < this.otpLength) {
        this.removeInputValue(this.inputRefs[idx]);
        idx++;
      }
    },

    clearSoftAfterInput(idx) {
      if (idx < 0) idx = 0;

      while (idx < this.otpLength) {
        this.otp[idx] = null;
        this.removeInputValue(this.inputRefs[idx]);
        idx++;
      }
    },

    emitEvent(eventName, payload) {
      this.$emit(eventName, payload);
    },

    emitEventChange(payload) {
      this.emitEvent(ON_INPUT_CHANGE_EVENT, payload);
    },

    emitEventComplete(payload) {
      this.emitEvent(ON_INPUT_COMPLETE_EVENT, payload);
    }

  },
  watch: {
    otp() {
      const otpLength = this.currentOtpLength;
      const idxCanGet = otpLength === this.otpLength ? this.currentInputCursorIndex : this.currentInputCursorIndex - 1; // onchange

      if (otpLength || otpLength === this.otpLength - 1) {
        const dataChange = {
          index: idxCanGet,
          value: this.otp[idxCanGet]
        };
        this.emitEventChange(dataChange);
      } // on complete


      if (otpLength === this.otpLength) {
        this.emitEventComplete([...this.otp]);
        this.blurInput(this.inputRefs[this.otpLength - 1]);
      }
    }

  }
};

function normalizeComponent(template, style, script, scopeId, isFunctionalTemplate, moduleIdentifier /* server only */, shadowMode, createInjector, createInjectorSSR, createInjectorShadow) {
    if (typeof shadowMode !== 'boolean') {
        createInjectorSSR = createInjector;
        createInjector = shadowMode;
        shadowMode = false;
    }
    // Vue.extend constructor export interop.
    const options = typeof script === 'function' ? script.options : script;
    // render functions
    if (template && template.render) {
        options.render = template.render;
        options.staticRenderFns = template.staticRenderFns;
        options._compiled = true;
        // functional template
        if (isFunctionalTemplate) {
            options.functional = true;
        }
    }
    // scopedId
    if (scopeId) {
        options._scopeId = scopeId;
    }
    let hook;
    if (moduleIdentifier) {
        // server build
        hook = function (context) {
            // 2.3 injection
            context =
                context || // cached call
                    (this.$vnode && this.$vnode.ssrContext) || // stateful
                    (this.parent && this.parent.$vnode && this.parent.$vnode.ssrContext); // functional
            // 2.2 with runInNewContext: true
            if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
                context = __VUE_SSR_CONTEXT__;
            }
            // inject component styles
            if (style) {
                style.call(this, createInjectorSSR(context));
            }
            // register component module identifier for async chunk inference
            if (context && context._registeredComponents) {
                context._registeredComponents.add(moduleIdentifier);
            }
        };
        // used by ssr in case component is cached and beforeCreate
        // never gets called
        options._ssrRegister = hook;
    }
    else if (style) {
        hook = shadowMode
            ? function (context) {
                style.call(this, createInjectorShadow(context, this.$root.$options.shadowRoot));
            }
            : function (context) {
                style.call(this, createInjector(context));
            };
    }
    if (hook) {
        if (options.functional) {
            // register for functional component in vue file
            const originalRender = options.render;
            options.render = function renderWithStyleInjection(h, context) {
                hook.call(context);
                return originalRender(h, context);
            };
        }
        else {
            // inject component registration as beforeCreate hook
            const existing = options.beforeCreate;
            options.beforeCreate = existing ? [].concat(existing, hook) : [hook];
        }
    }
    return script;
}

const isOldIE = typeof navigator !== 'undefined' &&
    /msie [6-9]\\b/.test(navigator.userAgent.toLowerCase());
function createInjector(context) {
    return (id, style) => addStyle(id, style);
}
let HEAD;
const styles = {};
function addStyle(id, css) {
    const group = isOldIE ? css.media || 'default' : id;
    const style = styles[group] || (styles[group] = { ids: new Set(), styles: [] });
    if (!style.ids.has(id)) {
        style.ids.add(id);
        let code = css.source;
        if (css.map) {
            // https://developer.chrome.com/devtools/docs/javascript-debugging
            // this makes source maps inside style tags work properly in Chrome
            code += '\n/*# sourceURL=' + css.map.sources[0] + ' */';
            // http://stackoverflow.com/a/26603875
            code +=
                '\n/*# sourceMappingURL=data:application/json;base64,' +
                    btoa(unescape(encodeURIComponent(JSON.stringify(css.map)))) +
                    ' */';
        }
        if (!style.element) {
            style.element = document.createElement('style');
            style.element.type = 'text/css';
            if (css.media)
                style.element.setAttribute('media', css.media);
            if (HEAD === undefined) {
                HEAD = document.head || document.getElementsByTagName('head')[0];
            }
            HEAD.appendChild(style.element);
        }
        if ('styleSheet' in style.element) {
            style.styles.push(code);
            style.element.styleSheet.cssText = style.styles
                .filter(Boolean)
                .join('\n');
        }
        else {
            const index = style.ids.size - 1;
            const textNode = document.createTextNode(code);
            const nodes = style.element.childNodes;
            if (nodes[index])
                style.element.removeChild(nodes[index]);
            if (nodes.length)
                style.element.insertBefore(textNode, nodes[index]);
            else
                style.element.appendChild(textNode);
        }
    }
}

/* script */
const __vue_script__ = script;
/* template */

var __vue_render__ = function () {
  var _vm = this;

  var _h = _vm.$createElement;

  var _c = _vm._self._c || _h;

  return _c('div', {
    staticClass: "vue-otp-2"
  }, _vm._l(_vm.otpLength * 2 - 1, function (v, i) {
    return _c('div', {
      key: i / 2
    }, [i % 2 === 0 ? _c('input', {
      ref: 'input' + i / 2,
      refInFor: true,
      attrs: {
        "minlength": "1",
        "maxlength": "1",
        "type": "text",
        "inputmode": _vm.inputMode,
        "pattern": _vm.inputPattern
      },
      on: {
        "input": _vm.handleInput,
        "keyup": _vm.handleKeyup,
        "focus": function ($event) {
          return _vm.handleFocus($event, i / 2);
        }
      }
    }) : _vm._e(), _vm._v(" "), i % 2 !== 0 && true ? _c('span', [_vm._v(_vm._s(_vm.character))]) : _vm._e()]);
  }), 0);
};

var __vue_staticRenderFns__ = [];
/* style */

const __vue_inject_styles__ = function (inject) {
  if (!inject) return;
  inject("data-v-10e5d926_0", {
    source: ".vue-otp-2[data-v-10e5d926]{display:flex;justify-content:space-between}.vue-otp-2 div[data-v-10e5d926]{flex:1;display:flex;align-items:center;justify-content:center}.vue-otp-2 div input[data-v-10e5d926]{max-width:30px;padding:11.5px 8px;font-size:20px;border-radius:3px;border:1px solid #cecece;text-align:center}.vue-otp-2 div span[data-v-10e5d926]{display:block;flex:1;text-align:center}",
    map: undefined,
    media: undefined
  });
};
/* scoped */


const __vue_scope_id__ = "data-v-10e5d926";
/* module identifier */

const __vue_module_identifier__ = undefined;
/* functional template */

const __vue_is_functional_template__ = false;
/* style inject SSR */

/* style inject shadow dom */

const __vue_component__ = /*#__PURE__*/normalizeComponent({
  render: __vue_render__,
  staticRenderFns: __vue_staticRenderFns__
}, __vue_inject_styles__, __vue_script__, __vue_scope_id__, __vue_is_functional_template__, __vue_module_identifier__, false, createInjector, undefined, undefined);

// Import vue component

const install = function installVueOtp2(Vue) {
  if (install.installed) return;
  install.installed = true;
  Vue.component('VueOtp2', __vue_component__);
}; // Create module definition for Vue.use()


const plugin = {
  install
}; // To auto-install when vue is found
// eslint-disable-next-line no-redeclare

/* global window, global */

let GlobalVue = null;

if (typeof window !== 'undefined') {
  GlobalVue = window.Vue;
} else if (typeof __webpack_require__.g !== 'undefined') {
  GlobalVue = __webpack_require__.g.Vue;
}

if (GlobalVue) {
  GlobalVue.use(plugin);
} // Inject install function into component - allows component
// to be registered via Vue.use() as well as Vue.component()


__vue_component__.install = install; // Export component by default
// also be used as directives, etc. - eg. import { RollupDemoDirective } from 'rollup-demo';
// export const RollupDemoDirective = component;

/* harmony default export */ __webpack_exports__["default"] = (__vue_component__);


/***/ }),

/***/ "./resources/js/src/views/pages/Lupa-password.vue":
/*!********************************************************!*\
  !*** ./resources/js/src/views/pages/Lupa-password.vue ***!
  \********************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _Lupa_password_vue_vue_type_template_id_c3f85fee_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true& */ "./resources/js/src/views/pages/Lupa-password.vue?vue&type=template&id=c3f85fee&scoped=true&");
/* harmony import */ var _Lupa_password_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./Lupa-password.vue?vue&type=script&lang=js& */ "./resources/js/src/views/pages/Lupa-password.vue?vue&type=script&lang=js&");
/* harmony import */ var _Lupa_password_vue_vue_type_style_index_0_id_c3f85fee_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true& */ "./resources/js/src/views/pages/Lupa-password.vue?vue&type=style&index=0&id=c3f85fee&lang=scss&scoped=true&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! !../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! !../../../../../node_modules/vuetify-loader/lib/runtime/installComponents.js */ "./node_modules/vuetify-loader/lib/runtime/installComponents.js");
/* harmony import */ var _node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4___default = /*#__PURE__*/__webpack_require__.n(_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4__);
/* harmony import */ var vuetify_lib_components_VBtn__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! vuetify/lib/components/VBtn */ "./node_modules/vuetify/lib/components/VBtn/VBtn.js");
/* harmony import */ var vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! vuetify/lib/components/VCard */ "./node_modules/vuetify/lib/components/VCard/VCard.js");
/* harmony import */ var vuetify_lib_components_VForm__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! vuetify/lib/components/VForm */ "./node_modules/vuetify/lib/components/VForm/VForm.js");
/* harmony import */ var vuetify_lib_components_VProgressCircular__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! vuetify/lib/components/VProgressCircular */ "./node_modules/vuetify/lib/components/VProgressCircular/VProgressCircular.js");
/* harmony import */ var vuetify_lib_components_VTextField__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! vuetify/lib/components/VTextField */ "./node_modules/vuetify/lib/components/VTextField/VTextField.js");



;


/* normalize component */

var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__["default"])(
  _Lupa_password_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _Lupa_password_vue_vue_type_template_id_c3f85fee_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render,
  _Lupa_password_vue_vue_type_template_id_c3f85fee_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  "c3f85fee",
  null
  
)

/* vuetify-loader */
;





_node_modules_vuetify_loader_lib_runtime_installComponents_js__WEBPACK_IMPORTED_MODULE_4___default()(component, {VBtn: vuetify_lib_components_VBtn__WEBPACK_IMPORTED_MODULE_5__["default"],VCard: vuetify_lib_components_VCard__WEBPACK_IMPORTED_MODULE_6__["default"],VForm: vuetify_lib_components_VForm__WEBPACK_IMPORTED_MODULE_7__["default"],VProgressCircular: vuetify_lib_components_VProgressCircular__WEBPACK_IMPORTED_MODULE_8__["default"],VTextField: vuetify_lib_components_VTextField__WEBPACK_IMPORTED_MODULE_9__["default"]})


/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/src/views/pages/Lupa-password.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ })

}]);