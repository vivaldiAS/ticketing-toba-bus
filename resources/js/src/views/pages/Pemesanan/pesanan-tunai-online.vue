<template>
    <v-app>
      <v-container>
        <h2>List Booking</h2>
        <v-data-table :headers="headers" :items="bookings">
          <template #item.harga_total="{ item }">
            {{ calculateTotalPrice(item) | toRupiah }}
          </template>
          <template #item.seat_number="{ item }">
            {{ item.seat_number.join(', ') }}
          </template>
          <template #item.actions="{ item }">
            <div v-if="item.payment_status === 'Berhasil'">
              <v-chip color="success" dark>
                Sudah Bayar
                <v-icon right>mdi-check-circle</v-icon>
              </v-chip>
            </div>
            <div v-else>
              <v-btn @click="confirmBooking(item)" :color="confirmButtonColor" small style="color: white;">Konfirmasi</v-btn>
              <v-btn @click="cancelBooking(item)" color="error" small>Batalkan</v-btn>
            </div>
          </template>
        </v-data-table>
      </v-container>
    </v-app>
  </template>
  
  <script>
  import axios from 'axios';
  import Swal from 'sweetalert2';
  
  export default {
    data() {
      return {
        bookings: [],
        headers: [
          { text: 'Nama', value: 'name' },
          { text: 'Jumlah Seat', value: 'num_seats' },
          { text: 'Nomor Bangku', value: 'seat_number' },
          { text: 'Harga Total', value: 'harga_total' },
          { text: 'Aksi', value: 'actions', sortable: false },
        ],
        confirmButtonColor: '#3D7C7F', // Warna untuk tombol "Konfirmasi"
      };
    },
    filters: {
      toRupiah(value) {
        const formatter = new Intl.NumberFormat('id-ID', {
          style: 'currency',
          currency: 'IDR',
          minimumFractionDigits: 0,
        });
        return formatter.format(value);
      },
    },
    methods: {
      getBookings() {
        const id = this.$route.params.id;
        axios.get(`/api/pesanan-online/${id}`)
          .then(response => {
            this.bookings = response.data;
          })
          .catch(error => {
            console.error(error);
          });
      },
      confirmBooking(item) {
        Swal.fire({
          title: 'Konfirmasi Booking',
          text: "Apakah Anda yakin ingin mengkonfirmasi booking ini?",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Ya, konfirmasi!',
          cancelButtonText: 'Batal'
        }).then((result) => {
          if (result.isConfirmed) {
            axios.put(`/api/konfirmasiberhasiltunai`, { payment_id: item.payment_id })
              .then(response => {
                this.getBookings(); // Refresh bookings data
                Swal.fire(
                  'Terkonfirmasi!',
                  'Booking telah dikonfirmasi.',
                  'success'
                );
              })
              .catch(error => {
                console.error(error);
                Swal.fire(
                  'Error!',
                  'Terjadi kesalahan saat mengkonfirmasi booking.',
                  'error'
                );
              });
          }
        });
      },
      cancelBooking(item) {
        Swal.fire({
          title: 'Batalkan Booking',
          text: "Apakah Anda yakin ingin membatalkan booking ini?",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Ya, batalkan!',
          cancelButtonText: 'Batal'
        }).then((result) => {
          if (result.isConfirmed) {
            axios.put(`/api/batalkanbooking`, { payment_id: item.payment_id })
              .then(response => {
                this.getBookings(); // Refresh bookings data
                Swal.fire(
                  'Dibatalkan!',
                  'Booking telah dibatalkan.',
                  'success'
                );
              })
              .catch(error => {
                console.error(error);
                Swal.fire(
                  'Error!',
                  'Terjadi kesalahan saat membatalkan booking.',
                  'error'
                );
              });
          }
        });
      },
      calculateTotalPrice(booking) {
        return booking.harga * booking.num_seats;
      }
    },
    mounted() {
      this.getBookings();
    }
  };
  </script>
  
  <style scoped>
  .v-data-table {
    margin-top: 20px;
  }
  </style>
  