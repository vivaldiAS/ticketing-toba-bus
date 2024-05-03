<!-- <template>
  <div>
    <h2>Client:</h2>
    <p>ID: {{ response.client?.id }}</p>
    <p>Name: {{ response.client?.name }}</p>

    <h2>Order:</h2>
    <p>Invoice Number: {{ response.order?.invoice_number }}</p>
    <p>Amount: {{ response.order?.amount }}</p>

    <h2>Virtual Account Info:</h2>
    <p>Virtual Account Number: {{ response.virtual_account_info?.virtual_account_number }}</p>
    <p>Status: {{ response.virtual_account_info?.status }}</p>
    <p>Created Date: {{ response.virtual_account_info?.created_date }}</p>
    <p>Expired Date: {{ response.virtual_account_info?.expired_date }}</p>
    <p>Expired In: {{ response.virtual_account_info?.expired_in }}</p>

    <h2>Customer:</h2>
    <p>Name: {{ response.customer?.name }}</p>
    <p>Email: {{ response.customer?.email }}</p>

    <h2>Payment Instructions:</h2>
    <ul>
      <li v-for="(instruction, index) in response.payment_instruction" :key="index">
        <h3>Channel: {{ instruction.channel }}</h3>
        <h3>Language: {{ instruction.language }}</h3>
        <ol>
          <li v-for="(step, index) in instruction.step" :key="index">{{ step }}</li>
        </ol>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      response: {
        client: {},
        order: {},
        virtual_account_info: {},
        customer: {},
        payment_instruction: [],
      },
    };
  },
  mounted() {
    const url = this.$route.params.howToPayApi;

    fetch(url)
      .then(response => response.text())
      .then(xmlString => {
        const parser = new DOMParser();
        const xmlDoc = parser.parseFromString(xmlString, 'text/xml');
        const responseNode = xmlDoc.getElementsByTagName('HowToPayResponseDto')[0];

        const clientNode = responseNode.getElementsByTagName('client')[0];
        const client = {
          id: clientNode?.getElementsByTagName('id')[0]?.textContent,
          name: clientNode?.getElementsByTagName('name')[0]?.textContent,
        };

        const orderNode = responseNode.getElementsByTagName('order')[0];
        const order = {
          invoice_number:  orderNode?.getElementsByTagName('invoice_number')[0]?.textContent,
          amount: orderNode?.getElementsByTagName('amount')[0]?.textContent,
        };

        const virtualAccountNode = responseNode.getElementsByTagName('virtual_account_info')[0];
        const virtualAccountInfo = {
          virtual_account_number: virtualAccountNode?.getElementsByTagName('virtual_account_number')[0]?.textContent,
          status: virtualAccountNode?.getElementsByTagName('status')[0]?.textContent,
          created_date: virtualAccountNode?.getElementsByTagName('created_date')[0]?.textContent,
          expired_date: virtualAccountNode?.getElementsByTagName('expired_date')[0]?.textContent,
          expired_in: virtualAccountNode?.getElementsByTagName('expired_in')[0]?.textContent,
        };

        const customerNode = responseNode.getElementsByTagName('customer')[0];
        const customer = {
          name: customerNode?.getElementsByTagName('name')[0]?.textContent,
          email: customerNode?.getElementsByTagName('email')[0]?.textContent,
        };

        const paymentInstructionNodes = responseNode.getElementsByTagName('payment_instruction');
        const paymentInstructions = [];
        for (let i = 0; i < paymentInstructionNodes.length; i++) {
          const instructionNode = paymentInstructionNodes[i];
          const channel = instructionNode.getElementsByTagName('channel')[0]?.textContent;
          const language = instructionNode.getElementsByTagName('language')[0]?.textContent;
          const stepNodes = instructionNode.getElementsByTagName('step');
          const steps = [];
          for (let j = 0; j < stepNodes.length; j++) {
            steps.push(stepNodes[j]?.textContent);
          }
          paymentInstructions.push({ channel, language, step: steps });
        }

        this.response = {
          client,
          order,
          virtual_account_info: virtualAccountInfo,
          customer,
          payment_instruction: paymentInstructions,
        };
      })
      .catch(error => {
        console.error('Error fetching XML:', error);
      });
  },
};
</script> -->
