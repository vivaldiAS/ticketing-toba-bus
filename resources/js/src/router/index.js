import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store/index'

Vue.use(VueRouter)

const routes = [{
    path: '/',
    name: 'pages-login',
    component: () => import('@/views/pages/Login.vue'),
    meta: {
      requiresAuth: false,
      layout: 'blank',
    },
  },
  {
    path: '/forgot-password',
    name: 'pages-forgot-password',
    component: () => import('@/views/pages/Lupa-password.vue'),
    meta: {
      requiresAuth: false,
      layout: 'blank',
    },
  },
  {
    path: '/reset-password/:email',
    name: 'pages-reset-password',
    component: () => import('@/views/pages/Password-reset.vue'),
    meta: {
      requiresAuth: false,
      layout: 'blank',
    },
  },
  {
    path: '/profile',
    name: 'pages-profile',
    component: () => import('@/views/pages/Profile/profile.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger', 'driver', 'admin_kantor', 'direksi'],
    },
  },
  {
    path: '/supir',
    name: 'pages-supir',
    component: () => import('@/views/pages/supir/list-supir.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/admin-loket',
    name: 'pages-admin-loket',
    component: () => import('@/views/pages/Admin Loket/list-admin-loket.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/add-admin-loket',
    name: 'pages-add-admin-loket',
    component: () => import('@/views/pages/Admin Loket/add-admin-loket.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/loket',
    name: 'pages-loket',
    component: () => import('@/views/pages/Loket/list-loket.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/add-loket',
    name: 'pages-add-loket',
    component: () => import('@/views/pages/Loket/add-loket.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/edit-loket/:id',
    name: 'pages-edit-lokets',
    component: () => import('@/views/pages/Loket/edit-loket.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/edit-user/:id',
    name: 'pages-edit-user',
    component: () => import('@/views/pages/edit-user.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/add-supir',
    name: 'pages-add-supir',
    component: () => import('@/views/pages/supir/add-supir.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/mobil',
    name: 'pages-mobil',
    component: () => import('@/views/pages/Mobil/list-mobil.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/add-mobil',
    name: 'pages-add-mobil',
    component: () => import('@/views/pages/Mobil/add-mobil.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/edit-mobil/:id',
    name: 'pages-edit-mobil',
    component: () => import('@/views/pages/Mobil/edit-mobil.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: 'admin_kantor',
    // },
  },
  {
    path: '/route',
    name: 'pages-routes',
    component: () => import('@/views/pages/Rute/list-route.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: 'admin_kantor',
    // },
  },
  {
    path: '/add-route',
    name: 'pages-add-route',
    component: () => import('@/views/pages/Rute/add-route.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: 'admin_kantor',
    // },
  },
  {
    path: '/edit-route/:id',
    name: 'pages-edit-route',
    component: () => import('@/views/pages/Rute/edit-route.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: 'admin_kantor',
    // },
  },
  {
    path: '/schedule',
    name: 'pages-schedule',
    component: () => import('@/views/pages/Schedule/list-schedule.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'admin_kantor',
    },
  },
  {
    path: '/add-schedule',
    name: 'pages-add-schedule',
    component: () => import('@/views/pages/Schedule/add-schedule.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: 'admin_kantor',
    // },
  },
  {
    path: '/edit-schedule/:id',
    name: 'pages-edit-schedule',
    component: () => import('@/views/pages/Schedule/edit-schedule.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: 'admin_kantor',
    // },
  },
  {
    path: '/pemesanan',
    name: 'pages-pemesanan',
    component: () => import('@/views/pages/Pemesanan/pemesanan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },

  },
  {
    path: '/costumize-pemesanan/',
    name: 'pages-costumize-pemesanan',
    component: () => import('@/views/pages/Pemesanan/costum_pesanan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/confirmasi-pemesanan',
    name: 'pages-confirmation-bookings',
    component: () => import('@/views/pages/Pemesanan/confirmasi_pesanan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/pembayaran',
    name: 'pembayaran',
    component: () => import('@/views/pages/Pembayaran/pembayaran-page.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/pembayaran-method',
    name: 'pembayaran-method',
    component: () => import('@/views/pages/Pembayaran/pembayaran-method.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/pembayaran-instruction/:howToPayApi',
    name: 'pembayaran-instruction',
    component: () => import('@/views/pages/Pembayaran/pembayaran-instruction.vue'),
    props: true,
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/pembayaran-instruction-bca/:howToPayApi',
    name: 'pembayaran-instruction-bca',
    component: () => import('@/views/pages/Pembayaran/pembayaran-instruction-bca.vue'),
    props: true,
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/all-bus',
    name: 'all-bus',
    component: () => import('@/views/pages/Pemesanan/pemesanan-by-penumpang.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'passenger',
    },
  },
  {
    path: '/dashboard',
    name: 'dashboard',
    component: () => import('@/views/dashboard/Dashboard.vue'),
    // meta: {
    //   requiresAuth: true,
    //   requiresRole: ['admin_loket', 'passenger', 'driver', 'admin_kantor', 'direksi'],
    // },
  },
  {
    path: '/Beranda',
    name: 'dashboard-penumpang',
    component: () => import('@/views/dashboard/DashboardPenumpang.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'passenger',
    },
  },
  {
    path: '/perjalanan-supir',
    name: 'perjalanan-supir',
    component: () => import('@/views/pages/Supir/riwayat-perjalanan-supir.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'driver',
    },
  },
  {
    path: '/riwayat-perjalanan',
    name: 'riwayat-perjalanan',
    component: () => import('@/views/pages/Pesanan/riwayat-perjalanan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'passenger',
    },

  },
  {
    path: '/penumpang',
    name: 'penumpang',
    component: () => import('@/views/pages/Supir/penumpang.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'driver',
    },
  },
  {
    path: '/pesananku',
    name: 'pesananku',
    component: () => import('@/views/pages/Pesanan/pesananku.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/e-ticket/:id',
    name: 'e-ticket',
    component: () => import('@/views/pages/Pesanan/e-Ticket.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'passenger'],
    },
  },
  {
    path: '/tracking/:schedule_id',
    name: 'tracking',
    component: () => import('@/views/pages/Tracking/tracking.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'passenger',
    },
  },
  {
    path: '/catatan-keuangan',
    name: 'catatan-keuangan',
    component: () => import('@/views/pages/Keuangan/catatan-keuangan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'direksi','admin_kantor'],
    },
  },
  {
    path: '/detail-catatan-keuangan/:tanggal',
    name: 'detail-catatan-keuangan',
    component: () => import('@/views/pages/Keuangan/detail-catatan-keuangan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'direksi', 'admin_kantor'],
    },
  },
  {
    path: '/detail-keuangan-by-penumpang/:id',
    name: 'detail-keuangan-by-penumpang',
    component: () => import('@/views/pages/Keuangan/detail-keuangan.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'direksi', 'admin_kantor'],
    },
  },
  {
    path: '/Komisi',
    name: 'komisi',
    component: () => import('@/views/pages/Komisi/komisi.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'direksi', 'admin_kantor'],
    },
  },
  {
    path: '/detail-Komisi/:tanggal',
    name: 'detail-komisi',
    component: () => import('@/views/pages/Komisi/detail-komisi.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: ['admin_loket', 'direksi', 'admin_kantor'],
    },
  },
  {
    path: '/penumpang-bus/:id',
    name: 'penumpang-bus',
    component: () => import('@/views/pages/Supir/penumpang-bus.vue'),
    meta: {
      requiresAuth: true,
      requiresRole: 'driver',
    },
  },
  {
    path: '/typography',
    name: 'typography',
    component: () => import('@/views/typography/Typography.vue'),
  },
  {
    path: '/icons',
    name: 'icons',
    component: () => import('@/views/icons/Icons.vue'),
  },
  {
    path: '/cards',
    name: 'cards',
    component: () => import('@/views/cards/Card.vue'),
  },
  {
    path: '/simple-table',
    name: 'simple-table',
    component: () => import('@/views/simple-table/SimpleTable.vue'),
  },
  {
    path: '/form-layouts',
    name: 'form-layouts',
    component: () => import('@/views/form-layouts/FormLayouts.vue'),
  },
  {
    path: '/pages/account-settings',
    name: 'pages-account-settings',
    component: () => import('@/views/pages/account-settings/AccountSettings.vue'),
  },
  // {
  //   path: '/pages/login',
  //   name: 'pages-login',
  //   component: () => import('@/views/pages/Login.vue'),
  //   meta: {
  //     layout: 'blank',
  //   },
  // },
  {
    path: '/pages/register',
    name: 'pages-register',
    component: () => import('@/views/pages/Register.vue'),
    meta: {
      layout: 'blank',
    },
  },
  {
    path: '/error-404',
    name: 'error-404',
    component: () => import('@/views/Error.vue'),
    meta: {
      layout: 'blank',

    },
  },
  {
    path: '*',
    redirect: 'error-404',
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
})

router.beforeEach((to, from, next) => {
  const {
    requiresAuth,
    requiresRole
  } = to.meta;

  if (requiresAuth && !store.getters.isAuthenticated) {
    return next('/'); // Redirect to the login page if not authenticated
  }

  if (requiresRole) {
    const roles = Array.isArray(requiresRole) ? requiresRole : [requiresRole];

    if (!roles.some(role => store.getters.hasRole(role))) {
      return next('/');
      // Redirect to the default page if the user does not have any required role
    }
  }

  next(); // Continue navigation
});

export default router
