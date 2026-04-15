function showToast() {
  const toast = document.getElementById("toast");
  toast.innerText = arguments[0] || "Operation completed.";
  toast.className = "toast show";
  toast.style.animation = `fadein 0.5s, fadeout 0.5s 4.8s`;
  setTimeout(() => { toast.className = toast.className.replace("show", ""); }, 5000);
}

(async function(){

const app = Vue.createApp({
    components: {
        'Home': Vue.defineAsyncComponent(httpVueLoader('vue-components/Home.vue')),
    },
    data() {
        return {
            activePage: 'Home',
            inputDirs: []
        }
    },
    computed: {
      navBack() {
        return this.activePage !== 'Home';
      }
    },
    mounted() {
        if (location.hash) {
            this.navTo(location.hash.substring(1));
        }
        window.onhashchange = (function() {
            const newHash = location.hash;
            console.log('The hash has changed to: ' + newHash);
            this.navTo(newHash ? newHash.substring(1) : 'Home');
        }.bind(this));
    },
    methods: {
        goBack() {
            history.back();
        },
        navTo(page) {
            this.activePage = page;
            console.log('Navigating to:', page);
        }
    }
})

app.mount('#app')

})();
