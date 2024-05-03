import {
  v4 as uuidv4
} from 'uuid';
import sha256 from 'crypto-js/sha256';
import hmacSHA512 from 'crypto-js/hmac-sha512';
import Base64 from 'crypto-js/enc-base64';
import cryptoJs from 'crypto-js';

const client_id = 'BRN-0215-1665721005141';
const secret_key = 'SK-3ut5p5VDAKku2Dqd541q';
const request_timestamp = new Date().toISOString().slice(0, 19)+"Z";

const doku = () => {
  const data = {
    "order": {
      "amount": 48720,
      "invoice_number": "INV-" + request_timestamp,
      "currency": "IDR",
      "session_id": "SU5WFDferd561dfasfasdfae123c",
      "callback_url": "https://doku.com/",
      "line_items": [{
        "name": "Biaya retribusi bulanan",
        "price": 48000,
        "quantity": 1
      }, {
        "name": "Biaya retribusi bulanan",
        "price": 720,
        "quantity": 1
      }]
    },
    "payment": {
      "payment_due_date": 60,
      "payment_method_types": [
        "QRIS"
      ]
    },
    "customer": {
      "name": "Anton Budiman",
      "email": "anton@doku.com",
      "phone": "+6285694566147",
      "address": "Plaza Asia Office Park Unit 3",
      "country": "ID"
    }
  };
  const requestId = uuidv4();
  const signature = generateSignature(data, requestId);
  console.log(signature);
}

export default doku;

function generateSignature(jsonBody, request_id) {
  var digestSHA256 = sha256(cryptoJs.enc.Utf8.parse(jsonBody));
  var digestBase64 = Base64.stringify(digestSHA256);
  console.log('Digest Component: ' + jsonBody)
  console.log('Digest sha256: ' + digestSHA256)
  console.log('Digest: ' + digestBase64)
  var signatureComponents = 'Client-Id:' + client_id + '\n' +
    'Request-Id:' + request_id + '\n' +
    'Request-Timestamp:' + request_timestamp + '\n' +
    'Request-Target:/checkout/v1/payment' + '\n' +
    'Digest:' + digestBase64;
  var signatureHmacSha256 = hmacSHA512(signatureComponents, secret_key);
  var signatureBase64 = Base64.stringify(signatureHmacSha256);
  console.log('Signature Components: ' + signatureComponents)
  console.log('Signature HMACSHA256: ' + signatureHmacSha256)
  console.log('Signature: ' + signatureBase64)
  return 'HMACSHA256=' + signatureBase64;
}
