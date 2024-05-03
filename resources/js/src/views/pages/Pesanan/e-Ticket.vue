<template>
  <div>
    <v-card-title> E-Ticket </v-card-title>
    <div>
      <v-menu right>
        <template v-slot:activator="{ on, attrs }">
          <v-btn class="setting" primary icon v-bind="attrs" v-on="on">
            <v-icon >{{ icons.mdiDotsVertical }}</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-item @click="downloadCard">
            <v-list-item-title>
              <v-icon>{{ icons.mdiDownload }}</v-icon> Download</v-list-item-title
            >
          </v-list-item>
          <v-list-item @click="CetakCard">
            <v-list-item-title>
              <v-icon>{{ icons.mdiPrinter }}</v-icon> Cetak</v-list-item-title
            >
          </v-list-item>
        </v-list>
      </v-menu>
    </div>
    <v-card width="600px" class="mx-auto p-3 card">
      <div class="ticket">
        <div class="ticket__content">
          <div class="ticket_isi">
            <v-avatar size="40" class="mt-2 ml-2 logo">
              <img
                :src="require('@/assets/images/logos/logo-KBT.png').default"
                max-height="50px"
                max-width="100px"
                alt="avatar"
              />
            </v-avatar>

            <table class="borderless">
              <tr>
                <td class="label">Nama</td>
                <td class="label">No Handphone</td>
              </tr>
              <tr>
                <td class="value">{{ this.ticket.name }}</td>
                <td class="value">{{ this.ticket.number_phone }}</td>
              </tr>
              <tr>
                <td class="label">Rute</td>
                <td class="label">Tipe</td>
              </tr>
              <tr>
                <td class="value">
                  {{ this.ticket.derpature }} - {{ this.ticket.arrival }}
                </td>
                <td class="value">{{ this.ticket.type }}</td>
              </tr>
              <tr>
                <td class="label">No Bus</td>
                <td class="label">No Bangku</td>
              </tr>
              <tr>
                <td class="value">{{ this.ticket.nomor_pintu }}</td>
                <td class="value">{{ this.ticket.num_seats }}</td>
              </tr>
              <tr>
                <td class="label">Tanggal</td>
                <td class="label">Harga</td>
              </tr>
              <tr>
                <td class="value">{{ this.ticket.tanggal }}</td>
                <td class="value">{{ this.ticket.harga | toRupiah }}</td>
              </tr>
              <!-- Tambahkan baris tambahan jika diperlukan -->
            </table>
          </div>
          <p class="ticket__text">e-KBT</p>
        </div>
      </div>
    </v-card>
  </div>
</template>

<script>
import jsPDF from "jspdf";
import "jspdf-autotable";
import axios from "axios";
import "moment/locale/id";
import html2canvas from "html2canvas";
import { mdiDotsVertical, mdiDownload, mdiPrinter } from "@mdi/js";

// import { Printer, PosPrintMode } from "escpos-printer";

export default {
  setup() {
    return {
      icons: {
        mdiDotsVertical,
        mdiDownload,
        mdiPrinter,
      },
    };
  },
  computed: {},
  data() {
    return {
      ticket: "",
      contentHtml: "",
    };
  },

  mounted() {
    this.getTIckets();
  },
  filters: {
    toRupiah(value) {
      const formatter = new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 2,
      });
      return formatter.format(value);
    },
  },

  methods: {
    getTIckets() {
      const access_token = localStorage.getItem("access_token");

      axios
        .get(`/api/pesanan/ticket/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${access_token}`,
          },
        })
        .then((response) => {
          this.ticket = response.data.data[0];
          console.log(this.ticket);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    downloadCard() {
      const doc = new jsPDF();
      const contentHtml = this.contentHtml;

      html2canvas(document.querySelector(".ticket"), {
        useCORS: true,
        scale: 2, // Menambahkan opsi skala
        scrollX: 0,
        scrollY: 0,
        windowWidth: document.querySelector(".card").scrollWidth,
        windowHeight: document.querySelector(".card").scrollHeight,
      }).then((canvas) => {
        const imgData = canvas.toDataURL("image/png");
        const imgProps = doc.getImageProperties(imgData);
        const pdfWidth = doc.internal.pageSize.getWidth(); // Lebar halaman PDF
        const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width; // Menghitung tinggi halaman PDF berdasarkan aspek rasio gambar

        doc.addImage(imgData, "PNG", 20, 20, pdfWidth - 50, pdfHeight - 40); // Menggunakan ukuran halaman PDF yang dihitung

        doc.save("Ticket-KBT");
      });
    },
    CetakCard() {
      const doc = new jsPDF({
        format: [60, Infinity],
      });

      // Set the document properties
      doc.setProperties({
        title: "E-ticket Koperasi Bintang Tapanuli (KBT)",
        author: "Your Name",
        subject: "E-ticket Koperasi Bintang Tapanuli (KBT)",
        keywords: "E-ticket Koperasi Bintang Tapanuli (KBT), bus, passenger",
        creator: "Your Name",
      });

      const logoImg = new Image();
      logoImg.src = require("@/assets/images/logos/logo-KBT.png").default;
      doc.addImage(logoImg, "PNG", 5, 8, 8, 8);

      // Add the header for the ticket
      doc.setFontSize(10);
      doc.setFont("helvetica", "bold");
      doc.text("Ticket", doc.internal.pageSize.getWidth() / 2, 12, { align: "center" });
      doc.text("Koperasi Bintang Tapanuli", doc.internal.pageSize.getWidth() / 2, 19, {
        align: "center",
      });
      doc.text(
        "--------------------------------------------",
        doc.internal.pageSize.getWidth() / 2,
        25,
        { align: "center" }
      );

      // Define the data for the ticket
      const ticketData = [
        { label: "BUS :", value: this.ticket.nomor_pintu.toString() },
        { label: "Tanggal:", value: this.ticket.tanggal.toString() },
        { label: "Nama :", value: this.ticket.name.toString() },
        { label: "Tipe :", value: this.ticket.type.toString() },
        { label: "No.Hp :", value: this.ticket.number_phone.toString() },
        { label: "Asal :", value: this.ticket.derpature.toString() },
        { label: "Bangku :", value: this.ticket.num_seats.toString() },
        { label: "Tujuan :", value: this.ticket.arrival.toString() },
        { label: "Tarif : ", value: "Rp " + this.ticket.harga.toString() },
      ];

      // Set initial position for content
      let contentX = 2;
      let contentY = 32;

      // Loop through the ticket data and add to the PDF
      for (let i = 0; i < ticketData.length; i++) {
        const { label, value } = ticketData[i];
        doc.setFontSize(9);
        doc.setFont("helvetica", "normal");

        doc.text(label, contentX, contentY);

        // Check if the value length exceeds 10 characters
        if (value.length > 10) {
          const splitValue = doc.splitTextToSize(value, 50); // Split the value into multiple lines
          doc.text(splitValue, contentX + 20, contentY);
          contentY += splitValue.length * 6; // Increase the Y position based on the number of lines
        } else {
          doc.text(value, contentX + 20, contentY);
          contentY += 6; // Increase the Y position for the next line
        }
      }

      // Print the PDF document
      doc.autoPrint();
      doc.output("dataurlnewwindow");
    },
  },
};
</script>
<style scoped>
.setting{
  position: absolute;
  right: 40px;
  top: 20px;
}
.ticket {
  position: relative;
  box-sizing: border-box;
  width: 600px;
  height: 350px;
  margin: 30px auto 0;
  padding: 20px;
  border-radius: 10px;
  background: #fbfbfb;
  box-shadow: 2px 2px 15px 0px #d1d1d1;
}

.ticket:before,
.ticket:after {
  content: "";
  position: absolute;
  left: 5px;
  height: 6px;
  width: 590px;
}

.ticket:before {
  top: -5px;
  background: radial-gradient(
      circle,
      transparent,
      transparent 50%,
      #fbfbfb 50%,
      #fbfbfb 100%
    ) -7px -8px / 16px 16px repeat-x;
}

.ticket:after {
  bottom: -5px;
  background: radial-gradient(
      circle,
      transparent,
      transparent 50%,
      #fbfbfb 50%,
      #fbfbfb 100%
    ) -7px -2px / 16px 16px repeat-x;
}

.ticket__content {
  box-sizing: border-box;
  height: 100%;
  width: 100%;
  border: 6px solid #d8d8d8;
}

.ticket__text {
  position: absolute;
  top: 120px;
  width: 600px;
  font-family: "Helvetica", "Arial", sans-serif;
  left: 200px;
  font-size: 3rem;
  font-weight: 600;
  color: #c6dede;
  opacity: 50%;
}
.logo {
  position: absolute;
  top: 80px;
  opacity: 30%;
  right: 300px;
}

.borderless {
  border-collapse: collapse;
}

.borderless td {
  border: none;
  padding: 6px;
}
.value {
  text-transform: uppercase;
  font-weight: bold;
  font-size: 16px;
  margin-top: 10px;
  width: 70%;
}
.label {
  font-style: italic;
}
.header {
  position: absolute;
  top: 30px;
  right: 150px;
}
</style>
