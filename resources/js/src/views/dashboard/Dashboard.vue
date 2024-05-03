<template>
  <div>

    <div v-if="userRole == 'passenger'">
      <DashboardPenumpang></DashboardPenumpang>
    </div>
    <div v-if="userRole == 'driver'">
      <DashboardDriver></DashboardDriver>
    </div>
    <div v-if="userRole == 'admin_loket'">
      <DashboardAdmin></DashboardAdmin>
    </div>
    <div v-if="userRole == 'admin_kantor'">
      <DashboardAdminLoket></DashboardAdminLoket>
    </div>
    <div v-if="userRole == 'direksi'">
      <DashboardDireksi></DashboardDireksi>
    </div>
  </div>
</template>
<script>

import DashboardAdmin from './DashboardAdmin.vue';
import DashboardPenumpang from './DashboardPenumpang.vue';
import DashboardDriver from './DashboardDriver.vue';
import DashboardAdminLoket from './DashboardAdminLoket.vue';
import DashboardDireksi from './DashboardDireksi.vue'
export default {
  data(){
    return{}
  },
  components:{
    DashboardAdmin,
    DashboardPenumpang,
    DashboardDriver,
    DashboardAdminLoket,
    DashboardDireksi
  },
  computed: {
    userRole() {
      return this.$store.state.userRole
    },
  }
}
</script>
