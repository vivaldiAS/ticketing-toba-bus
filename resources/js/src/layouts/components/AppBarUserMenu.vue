<template>
  <v-menu offset-y left nudge-bottom="14" min-width="230" content-class="user-profile-menu-content">
    <template v-slot:activator="{ on, attrs }">
      <v-badge bottom color="success" overlap offset-x="12" offset-y="12" class="ms-4" dot>
        <v-avatar size="40px" v-bind="attrs" v-on="on">
          <v-img :src="require('@/assets/images/avatars/1.png').default"></v-img>
        </v-avatar>
      </v-badge>
    </template>
    <v-list>
      <div class="pb-3 pt-2">
        <v-badge bottom color="success" overlap offset-x="12" offset-y="12" class="ms-4" dot>
          <v-avatar size="40px">
            <v-img :src="require('@/assets/images/avatars/1.png').default"></v-img>
          </v-avatar>
        </v-badge>
        <div class="d-inline-flex flex-column justify-center ms-3" style="vertical-align: middle">
          <span class="text--primary text-capitalize font-weight-semibold mb-n1"> {{ user.name }}</span>
          <small class="text--disabled">{{ user.email }}</small>
        </div>
      </div>

      <!-- <v-divider></v-divider> -->

      <!-- Profile -->
      <v-list-item link :to="{ name: 'pages-profile'}">
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiAccountOutline }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title >Profile</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <!-- Email -->
      <!-- <v-list-item link>
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiEmailOutline }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>Inbox</v-list-item-title>
        </v-list-item-content>
      </v-list-item> -->

      <!-- Chat -->
      <!-- <v-list-item link>
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiChatOutline }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>Chat</v-list-item-title>
        </v-list-item-content>

        <v-list-item-action>
          <v-badge inline color="error" content="2"> </v-badge>
        </v-list-item-action>
      </v-list-item> -->

      <!-- <v-divider class="my-2"></v-divider> -->

      <!-- Settings -->
      <!-- <v-list-item link>
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiCogOutline }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>Settings</v-list-item-title>
        </v-list-item-content>
      </v-list-item> -->

      <!-- Pricing -->
      <!-- <v-list-item link>
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiCurrencyUsd }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>Pricing</v-list-item-title>
        </v-list-item-content>
      </v-list-item> -->

      <!-- FAQ -->
      <!-- <v-list-item link>
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiHelpCircleOutline }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>FAQ</v-list-item-title>
        </v-list-item-content>
      </v-list-item> -->

      <v-divider class="my-2"></v-divider>

      <!-- Logout -->
      <v-list-item link @click.prevent="logout">
        <v-list-item-icon class="me-2">
          <v-icon size="22">
            {{ icons.mdiLogoutVariant }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>Logout</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>


import {
mdiAccountOutline,
mdiEmailOutline,
mdiCheckboxMarkedOutline,
mdiChatOutline,
mdiCogOutline,
mdiCurrencyUsd,
mdiHelpCircleOutline,
mdiLogoutVariant,

} from '@mdi/js'
import axios from 'axios';
import Swal from 'sweetalert2'
export default {
setup() {
  return {
    icons: {
      mdiAccountOutline,
      mdiEmailOutline,
      mdiCheckboxMarkedOutline,
      mdiChatOutline,
      mdiCogOutline,
      mdiCurrencyUsd,
      mdiHelpCircleOutline,
      mdiLogoutVariant,
    },

  }
},
data() {
  return {
    user: {}
  }
},
methods: {
  logout() {
    Swal.fire({
      icon: 'question',
      title: 'Apakah anda ingin keluar dari aplikasi?',
      showCancelButton: true,
      confirmButtonText: 'Ya',
      cancelButtonText: 'Tidak',
      confirmButtonColor: '#307475',


    }).then((result) => {
      /* Read more about isConfirmed, isDenied below */
      if (result.isConfirmed) {
        axios.post('/api/logout', null, {
          headers: {
            Authorization: 'Bearer ' + localStorage.getItem('access_token')
          }
        })
          .then(response => {
            localStorage.removeItem('access_token');
            localStorage.removeItem('user_data');
            localStorage.removeItem('expires_at');
            this.$store.commit('SET_USER_ROLE', '');
            this.$router.push('/');
          })
          .catch(error => {
            console.log(error.response.data.message);
          });
      }
    })
  }
},
mounted() {
  const access_token = localStorage.getItem('access_token');
  axios.get('api/user/profile', {
    headers: {
      'Authorization': `Bearer ${access_token}`
    }
  }).then(response => {
    this.user = response.data;
  }).catch(error => {
    console.log(error);
  })
}
}
</script>

<style lang="scss">
.user-profile-menu-content {
  .v-list-item {
    min-height: 2.5rem !important;
  }
}
</style>
