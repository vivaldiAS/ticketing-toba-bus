<template>
  <v-navigation-drawer
    :value="isDrawerOpen"
    app
    floating
    width="260"
    color="primary"
    class="app-navigation-menu"
    :right="$vuetify.rtl"
    @input="(val) => $emit('update:is-drawer-open', val)"
  >
    <div
      class="vertical-nav-header d-flex items-center ps-6 pe-5 pt-5 pb-2"
      color="primary"
      style="display: flex; justify-content: center; " 
    >
      <router-link to="/dashboard" class="d-flex align-center text-decoration-none">
        <v-img
          :src="require('@/assets/images/logo/logo-no-background-putih.png').default"
          max-height="50px"
          max-width="100px"
          alt="logo"
          contain
          eager
          class="app-logo me-auto"
          color="secondary"
        ></v-img>
      </router-link>
    </div>

    <!-- Navigation Items -->
    <v-list expand shaped class="vertical-nav-menu-items pr-5" text-color="white">
      <nav-menu-link
        title="Dashboard"
        :to="{ name: 'dashboard' }"
        :icon="icons.mdiHomeOutline"
      ></nav-menu-link>
      <div v-if="userRole === 'admin_loket'">
        <nav-menu-link
          title="Pesan Ticket "
          :to="{ name: 'pages-pemesanan' }"
          :icon="icons.mdiCreditCardOutline"
        ></nav-menu-link>
        
        <nav-menu-link
          title="Konfirmasi Pesanan"
          :to="{ name: 'konfirmasi-booking-tunai' }"
          :icon="icons.mdiCheckCircle"
        ></nav-menu-link>

        <nav-menu-link
          title="Riwayat Pesanan"
          :to="{ name: 'pesananku' }"
          :icon="icons.mdiCar"
        ></nav-menu-link>
        <nav-menu-link
          title="Catatan Keuangan "
          :to="{ name: 'catatan-keuangan' }"
          :icon="icons.mdiCashCheck"
        ></nav-menu-link>
        <nav-menu-link
          title="Komisi"
          :to="{ name: 'komisi' }"
          :icon="icons.mdiCurrencyUsd"
        ></nav-menu-link>
      </div>
      <div v-if="userRole === 'admin_kantor'">
        <nav-menu-group title="Loket" :icon="icons.mdiCarCog">
          <nav-menu-link
            title="Admin Loket"
            :to="{ name: 'pages-admin-loket' }"
            :icon="icons.mdiAccountTie"
          ></nav-menu-link>
          <nav-menu-link
            title="Loket"
            :to="{ name: 'pages-loket' }"
            :icon="icons.mdiCar"
          ></nav-menu-link>
        </nav-menu-group>
        <nav-menu-link
          title="Sopir"
          :to="{ name: 'pages-supir' }"
          :icon="icons.mdiCardAccountDetailsOutline"
        ></nav-menu-link>
        <nav-menu-link
          title="Mobil"
          :to="{ name: 'pages-mobil' }"
          :icon="icons.mdiCar"
        ></nav-menu-link>
        <nav-menu-link
          title="Rute"
          :to="{ name: 'pages-routes' }"
          :icon="icons.mdiMapMarkerDistance"
        ></nav-menu-link>
        <nav-menu-link
          title="Jadwal "
          :to="{ name: 'pages-schedule' }"
          :icon="icons.mdiCreditCardOutline"
        ></nav-menu-link>

        <nav-menu-link
            title="Jadwal Default"
            :to="{ name: 'pages-default-schedule' }"
            :icon="icons.mdiCalendarWeek"
        ></nav-menu-link>

        <nav-menu-link
          title="Catatan Keuangan"
          :to="{ name: 'catatan-keuangan' }"
          :icon="icons.mdiCashCheck"
        ></nav-menu-link>
        <nav-menu-link
          title="Komisi"
          :to="{ name: 'komisi' }"
          :icon="icons.mdiCurrencyUsd"
        ></nav-menu-link>
      </div>
      <div v-if="userRole === 'passenger'">
        <nav-menu-link
          title="Pesan E-ticket"
          :to="{ name: 'all-bus' }"
          :icon="icons.mdiCardAccountDetailsOutline"
        ></nav-menu-link>
        <nav-menu-link
          title="Pesananku"
          :to="{ name: 'pesananku' }"
          :icon="icons.mdiCar"
        ></nav-menu-link>
        <nav-menu-link
          title="Riwayat Perjalanan"
          :to="{ name: 'riwayat-perjalanan' }"
          :icon="icons.mdiHistory"
        ></nav-menu-link>
      </div>
      <div v-if="userRole === 'driver'">
        <nav-menu-link
          title="Penumpang"
          :to="{ name: 'penumpang' }"
          :icon="icons.mdiCardAccountDetailsOutline"
        ></nav-menu-link>
        <nav-menu-link
          title="Riwayat Perjalanan"
          :to="{ name: 'perjalanan-supir' }"
          :icon="icons.mdiHistory"
        ></nav-menu-link>
      </div>
      <div v-if="userRole === 'direksi'">
        <nav-menu-link
          title="Admin Kantor"
          :to="{ name: 'list-admin-kantor' }"
          :icon="icons.mdiDesk"
        ></nav-menu-link>
        <nav-menu-link
          title="Merk"
          :to="{ name: 'list-brands' }"
          :icon="icons.mdiTag"
        ></nav-menu-link>
        <!-- <nav-menu-link
          title="Catatan Keuangan"
          :to="{ name: 'catatan-keuangan' }"
          :icon="icons.mdiCashCheck"
        ></nav-menu-link>
        <nav-menu-link
          title="Komisi"
          :to="{ name: 'komisi' }"
          :icon="icons.mdiCurrencyUsd"
        ></nav-menu-link> -->
      </div>
      <div v-if="!userRole">
        <!-- Default Menu for unknown role -->
        <nav-menu-link
          title="Pesan E-ticket"
          :to="{ name: 'all-bus' }"
          :icon="icons.mdiCardAccountDetailsOutline"
        ></nav-menu-link>
        <nav-menu-link
          title="Pesananku"
          :to="{ name: 'pesananku' }"
          :icon="icons.mdiCar"
        ></nav-menu-link>
        <nav-menu-link
          title="Riwayat Perjalanan"
          :to="{ name: 'riwayat-perjalanan' }"
          :icon="icons.mdiHistory"
        ></nav-menu-link>
      </div>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import {
  mdiAccountTie,
  mdiHomeOutline,
  mdiAlphaTBoxOutline,
  mdiEyeOutline,
  mdiCreditCardOutline,
  mdiCheckCircle,
  mdiTable,
  mdiFileOutline,
  mdiFormSelect,
  mdiAccountCogOutline,
  mdiCardAccountDetailsOutline,
  mdiCar,
  mdiCarCog,
  mdiMapMarkerDistance,
  mdiHistory,
  mdiCurrencyUsd,
  mdiCashCheck,
  mdiDesk,
  mdiTag,
  mdiCalendarWeek
} from "@mdi/js";
import NavMenuSectionTitle from "./components/NavMenuSectionTitle.vue";
import NavMenuGroup from "./components/NavMenuGroup.vue";
import NavMenuLink from "./components/NavMenuLink.vue";

export default {
  components: {
    NavMenuSectionTitle,
    NavMenuGroup,
    NavMenuLink,
  },
  props: {
    isDrawerOpen: {
      type: Boolean,
      default: null,
    },
  },
  setup() {
    return {
      icons: {
        mdiHomeOutline,
        mdiAccountTie,
        mdiAlphaTBoxOutline,
        mdiEyeOutline,
        mdiCreditCardOutline,
        mdiCheckCircle,
        mdiTable,
        mdiFileOutline,
        mdiFormSelect,
        mdiAccountCogOutline,
        mdiCardAccountDetailsOutline,
        mdiCar,
        mdiMapMarkerDistance,
        mdiCarCog,
        mdiHistory,
        mdiCurrencyUsd,
        mdiCashCheck,
        mdiDesk,
        mdiTag,
        mdiCalendarWeek
      },
    };
  },
  computed: {
    userRole() {
      return this.$store.state.userRole;
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@resources/sass/preset/mixins.scss";

.app-title {
  font-size: 1.25rem;
  font-weight: 700;
  font-stretch: normal;
  font-style: normal;
  line-height: normal;
  letter-spacing: 0.3px;
}

.app-logo {
  transition: all 0.18s ease-in-out;

  .v-navigation-drawer--mini-variant & {
    transform: translateX(-4px);
  }
}

@include theme(app-navigation-menu) using ($material) {
  background-color: map-deep-get($material, "background");
}

.app-navigation-menu {
  .v-list-item {
    &.vertical-nav-menu-link {
      color: white;

      ::v-deep .v-list-item__icon {
        .v-icon {
          transition: none !important;
        }
      }
    }
  }
}

.app-navigation-menu {
  .upgrade-banner {
    position: absolute;
    bottom: 13px;
    left: 50%;
    transform: translateX(-50%);
  }
}
</style>
