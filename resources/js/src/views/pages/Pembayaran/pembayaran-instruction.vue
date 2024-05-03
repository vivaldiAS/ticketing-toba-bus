<template>
  <div class="payment-gateway">
    <div v-if="paymentInstructions.virtual_account_info.status == 'OPEN'">
      <h2>How to Pay</h2>
      <div class="payment-details">
        <p>
          <strong>Virtual Account Number:</strong>
          <span class="virtual-account-number">{{
            paymentInstructions.virtual_account_info.virtual_account_number
          }}</span>
          <button class="copy-button" @click="copyVirtualAccountNumber">Copy</button>
        </p>
        <p><strong>Amount:</strong> {{ paymentInstructions.order.amount }}</p>
        <p>
          <strong>Status:</strong> {{ paymentInstructions.virtual_account_info.status }}
        </p>
      </div>

      <v-expansion-panels>
        <v-expansion-panel
          v-for="instruction in paymentInstructions.payment_instruction"
          :key="instruction.channel"
        >
          <v-expansion-panel-header>{{ instruction.channel }}</v-expansion-panel-header>
          <v-expansion-panel-content>
            <ol>
              <li v-for="step in instruction.step" :key="step">{{ step }}</li>
            </ol>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>

    <v-card
      v-if="paymentInstructions.virtual_account_info.status == 'PAID'"
      class="payment-success-card"
    >
      <div class="checklist-icon-container">
        <img
          :src="require('@/assets/images/check.gif').default"
          width="100px"
          alt="avatar"
        />
      </div>
      <div class="payment-success-content">
        <h3 style="color: #76ae46">Berhasil</h3>
        <p>{{ paymentInstructions.order.invoice_number }}</p>
        <p><strong>Amount:</strong> Rp.{{ paymentInstructions.order.amount }}</p>
        <p>
          <strong>No. Virtual Account:</strong>
          {{ paymentInstructions.virtual_account_info.virtual_account_number }}
        </p>
        <p>
          <strong></strong> {{ paymentInstructions.virtual_account_info.created_date }}
        </p>
        <p><strong>Nama:</strong> {{ paymentInstructions.customer.name }}</p>
      </div>
    </v-card>
  </div>
</template>

<style>
/* Styles for the copy button */
.copy-button {
  margin-left: 10px;
  cursor: pointer;
}

/* Styles for the virtual account number */
.virtual-account-number {
  font-weight: bold;
  padding: 2px 5px;
  background-color: #f2f2f2;
  border: 1px solid #ccc;
  border-radius: 3px;
}

/* Styles for the payment success card */
.payment-success-card {
  width: 500px;
  margin: 0 auto;
  text-align: center;
  padding: 20px;
}

.checklist-icon {
  font-size: 200px;
}

/* Rest of the styles remain the same */
/* ... */
</style>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      paymentInstructions: []
    };
  },
  mounted() {
    // Fetch the initial payment instructions
  this.fetchPaymentStatus();

  // Start a timer to fetch the updated status every 10 seconds (adjust the interval as needed)
  this.statusUpdateTimer = setInterval(() => {
    this.fetchPaymentStatus();
  }, 3000);
  },
  methods: {
    copyVirtualAccountNumber() {
      const virtualAccountNumber = this.paymentInstructions.virtual_account_info.virtual_account_number;
      const tempInput = document.createElement('input');
      tempInput.value = virtualAccountNumber;
      document.body.appendChild(tempInput);
      tempInput.select();
      document.execCommand('copy');
      document.body.removeChild(tempInput);
    },

    fetchPaymentStatus(){
      const access_token = localStorage.getItem('access_token');
    let url = this.$route.params.howToPayApi
    axios.get(url, {
      headers: {
        'Authorization': `Bearer ${access_token}`
      }
    }).then(response => {
      this.paymentInstructions = response.data;
    }).catch(error => {
      console.log(error);
    });
    }
  },
  beforeDestroy() {
  // Clear the timer to avoid memory leaks
  clearInterval(this.statusUpdateTimer);
},
}
</script>
