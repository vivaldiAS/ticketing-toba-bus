<template>
  <v-card>
    <div class="profile-container">
      <v-img
        :src="require('@/assets/images/avatars/1.png').default"
        max-height="100px"
        max-width="100px"
        alt="logo"
        class="app-logo"
      ></v-img>
      <h4 class="nama">{{ user.name }}</h4>
    </div>
    <div style="margin-top: 50px">
      <!-- Menggunakan class setting-container untuk mengatur tata letak ikon dan teks -->
      <v-expansion-panels>
        <v-expansion-panel v-if="isEditing">
          <v-expansion-panel-header disable-icon-rotate>
            Edit Data Diri
            <template v-slot:actions>
              <v-icon color="teal">{{ icons.mdiCogOutline }}</v-icon>
            </template>
          </v-expansion-panel-header>
          <v-form ref="form" @submit.prevent="saveProfileChanges">
            <v-expansion-panel-content>
              <div class="edit-btn" @click="CloseEditProfile">
                <v-icon color="error">{{ icons.mdiClose }}</v-icon>
                <!-- <span>Batal</span> -->
              </div>

              <div class="data">
                <span>Nama</span>
                <h4 class="name">
                  <v-text-field v-model="editedUser.name" />
                </h4>
              </div>
              <div class="data">
                <span>Email</span>
                <h4 class="email" v>
                  <v-text-field v-model="editedUser.email" />
                </h4>
              </div>
              <div class="data">
                <span>Nomor Handphone</span>
                <h4 class="phone">
                  <v-text-field v-model="editedUser.phone_number" />
                </h4>
              </div>
              <div class="data">
                <span>Jenis Kelamin</span>
                <h4 class="gender">
                  <v-select
                    v-model="editedUser.gender"
                    :items="['Laki-laki', 'Perempuan']"
                  ></v-select>
                </h4>
              </div>
              <div class="data">
                <span>Alamat</span>
                <h4 class="address">
                  <v-text-field v-model="editedUser.address" />
                </h4>
              </div>
              <div class="text-rigth">
                <v-btn class="mt-2" color="primary" type="submit"> Simpan </v-btn>
              </div>
            </v-expansion-panel-content>
          </v-form>
        </v-expansion-panel>
        <v-expansion-panel v-else>
          <v-expansion-panel-header disable-icon-rotate>
            Data Diri
            <template v-slot:actions>
              <v-icon color="primary">{{ icons.mdiCogOutline }}</v-icon>
            </template>
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            <div class="edit-btn" @click="editProfile">
              <v-icon color="teal">{{ icons.mdiPencil }}</v-icon>
              <!-- <span>Edit</span> -->
            </div>
            <div class="data">
              <span>Nama</span>
              <h4 class="name">{{ user.name }}</h4>
            </div>
            <div class="data">
              <span>Email</span>
              <h4 class="email">{{ user.email }}</h4>
            </div>
            <div class="data">
              <span>Nomor Handphone</span>

              <h4 class="phone">{{ user.phone_number }}</h4>
            </div>
            <div class="data">
              <span>Jenis Kelamin</span>

              <h4 class="gender">{{ user.gender }}</h4>
            </div>
            <div class="data">
              <span>Alamat</span>

              <h4 class="address">{{ user.address }}</h4>
            </div>
          </v-expansion-panel-content>
        </v-expansion-panel>

        <v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header disable-icon-rotate>
              Ubah Password
              <template v-slot:actions>
                <v-icon color="secondary">{{ icons.mdiKeyVariant }}</v-icon>
              </template>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <p class="span-pass">
                *Kata sandi Anda minimal harus enam karakter dan berisi kombinasi angka,
                huruf, dan karakter khusus
              </p>
              <v-form ref="form" @submit.prevent="updatePassword">
                <v-text-field
                  :type="isPasswordNowVisible ? 'text' : 'password'"
                  v-model="passwordData.current_password"
                  label="Password saat ini"
                  class="mb-1 mt-3"
                  placeholder="********"
                  :append-icon="
                    isPasswordNowVisible ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
                  "
                  hide-details
                  @click:append="isPasswordNowVisible = !isPasswordNowVisible"
                ></v-text-field>
                <v-text-field
                  :type="isPasswordNewVisible ? 'text' : 'password'"
                  v-model="passwordData.new_password"
                  label="Password baru"
                  class="mb-1 mt-3"
                  placeholder="********"
                  :append-icon="
                    isPasswordNewVisible ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
                  "
                  hide-details
                  @click:append="isPasswordNewVisible = !isPasswordNewVisible"
                ></v-text-field>
                <v-text-field
                  :type="isPasswordVisible ? 'text' : 'password'"
                  v-model="passwordData.new_password_confirmation"
                  label="Konfirmasi Password"
                  class="mb-1 mt-3"
                  placeholder="********"
                  :append-icon="
                    isPasswordVisible ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
                  "
                  hide-details
                  @click:append="isPasswordVisible = !isPasswordVisible"
                ></v-text-field>
                <div class="text-right">
                  <v-btn class="mt-2" color="primary" type="submit"> Simpan </v-btn>
                </div>
              </v-form>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panel>
      </v-expansion-panels>
      <div class="setting-container" @click="logout">
        <span class="text">Keluar</span>
        <v-icon class="icon" color="error">{{ icons.mdiPowerStandby }}</v-icon>
      </div>
    </div>
  </v-card>
</template>
<script>
import {
  mdiKeyVariant,
  mdiCogOutline,
  mdiPowerStandby,
  mdiPencil,
  mdiEyeOutline,
  mdiEyeOffOutline,
  mdiClose,
} from "@mdi/js";
import { ref } from "@vue/composition-api";

import axios from "axios";
import Swal from "sweetalert2";
export default {
  setup() {
    const isPasswordVisible = ref(false);
    const isPasswordNewVisible = ref(false);
    const isPasswordNowVisible = ref(false);
    return {
      isPasswordVisible,
      isPasswordNewVisible,
      isPasswordNowVisible,
      icons: {
        mdiKeyVariant,
        mdiCogOutline,
        mdiPowerStandby,
        mdiPencil,
        mdiEyeOutline,
        mdiEyeOffOutline,
        mdiClose,
      },
      editedUser: {},
      passwordData: {
        current_password: "",
        new_password: "",
        new_password_confirmation: "",
      },
    };
  },
  data() {
    return {
      user: {},
      loader: null,
      loading: false,
      isEditing: false,
    };
  },
  methods: {
    logout() {
      Swal.fire({
        icon: "question",
        title: "Apakah anda ingin keluar dari aplikasi?",
        showCancelButton: true,
        confirmButtonText: "Ya",
        cancelButtonText: "Tidak",
        confirmButtonColor: "#307475",
      }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
          axios
            .post("/api/logout", null, {
              headers: {
                Authorization: "Bearer " + localStorage.getItem("access_token"),
              },
            })
            .then((response) => {
              localStorage.removeItem("access_token");
              localStorage.removeItem("expires_at");
              localStorage.removeItem("user_data");
              this.$store.commit("SET_USER_ROLE", "");
              this.$router.push("/");
            })
            .catch((error) => {
              console.log(error.response.data.message);
            });
        }
      });
    },
    editProfile() {
      this.editedUser = { ...this.user };
      this.isEditing = true; // Aktifkan mode editing
    },
    CloseEditProfile() {
      this.isEditing = false; // Menonaktifkan mode editing
    },
    saveProfileChanges() {
      const access_token = localStorage.getItem("access_token");
      axios
        .put(`/api/user/update/${this.user.id}`, this.editedUser, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.user = response.data.data;
          console.log(response.data.data);
          this.isEditing = false;
          Swal.fire({
            icon: "success",
            title: "Profile berhasil di ubah!",
          });
          // window.location.reload();
        })
        .catch((error) => {
          console.log(error.response.data.message);
          Swal.fire({
            icon: "error",
            title: "Gagal",
            text: "Gagal mengubah profile",
          });
          this.$router.push("/profile");
        });
    },
    updatePassword() {
      const access_token = localStorage.getItem("access_token");
      const passwordData = {
        current_password: this.passwordData.current_password,
        new_password: this.passwordData.new_password,
        new_password_confirmation: this.passwordData.new_password_confirmation,
      };

      if (passwordData.new_password !== passwordData.new_password_confirmation) {
        Swal.fire({
          icon: "error",
          title: "Gagal",
          text: "Konfirmasi password baru tidak sesuai.",
        });
        return; // Return early if the confirmation password doesn't match
      }

      axios
        .post("/api/user/update-password", passwordData, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.passwordData.current_password = "";
          this.passwordData.new_password = "";
          this.passwordData.new_password_confirmation = "";
          Swal.fire({
            icon: "success",
            title: "Password berhasil diubah!",
          });
        })
        .catch((error) => {
          const status = error.response.status;

          if (status === 422) {
            const error_v = error.response.data.errors;
            // Display the first validation error message (assuming there's only one)
            const firstError = Object.values(error_v)[0][0];
            Swal.fire({
              icon: "error",
              title: "Gagal",
              text: firstError,
            });
          } else {
            const errors = error.response.data.error;
            console.log(errors);
            Swal.fire({
              icon: "error",
              title: "Gagal",
              text: errors,
            });
          }
        });
    },
  },
  mounted() {
    const access_token = localStorage.getItem("access_token");

    axios
      .get("api/user/profile", {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      })
      .then((response) => {
        this.user = response.data;
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>
<style scoped>
/* CSS untuk mengatur tata letak ikon dan teks */
.setting-container {
  display: flex;
  justify-content: space-between;
  padding: 15px;
}
.profile-container {
  margin-top: 20px;
  margin-bottom: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.app-logo {
  border-radius: 50%;
  border: 3px solid #307475;
  margin-top: 20px;
}
.nama {
  padding: 5px;
  color: black;
  text-transform: uppercase;
}
.edit-btn {
  position: absolute;
  right: 20px;
  cursor: pointer;
}
.data {
  padding: 10px;
}
.data span {
  opacity: 50%;
}
.span-pass {
  font-size: 10px;
  font-style: italic;
}
.btn-conf {
  display: flex;
  justify-content: center;
}
</style>
