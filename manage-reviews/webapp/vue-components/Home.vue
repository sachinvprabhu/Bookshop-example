<template>
  <a
    class="w3-button w3-xlarge w3-circle w3-theme-action"
    @click="addReview"
    style="position: fixed; bottom: 3rem; right: 2rem; padding-top: 6px"
    >+</a
  >

  <div v-if="reviews.length === 0" class="w3-container">
    <div class="w3-panel w3-amber w3-round-large">
      <p>
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
          No reviews found
      </p>
    </div>
  </div>

  <ul class="w3-ul w3-card-4">
    <li class="w3-bar" v-for="x in reviews">
      <i
        class="w3-bar-item w3-button w3-white w3-right w3-xlarge fa fa-trash w3-text-red"
        @click="removeReview(x)"
      ></i>
      <div class="thumb-container w3-bar-item">
        <img
          loading="lazy"
          style="cursor:pointer;"
          src="assets/image-placeholder.png"
          class="w3-round"
        />
      </div>
      <div class="w3-bar-item">
        <span class="w3-large">Book ID : {{ x.bookId }}</span>
        <br />
        <span class="w3-small">Review : {{ x.review }}</span>
      </div>
    </li>
  </ul>
</template>

<script>
module.exports = {
  data: function () {
    return {
      reviews : []
    };
  },
  mounted() {
    fetch("/booksReviews")
      .then(response=>response.json())
      .then(reviews=>{
        this.reviews = reviews;
      });
  },
  methods: {
    removeReview: function(data){
      fetch("/booksReviews/"+data.id,{
          method : "DELETE"
      }).then(response=>{
        showToast("Review Removed");
        return fetch("/booksReviews")
      })
      .then(response=>response.json())
      .then(reviews=>{
        this.reviews = reviews;
      });
    },
    addReview : function(){
      let bookId = prompt("Provide Book ID","b9405714-4184-4090-b8b8-1e4a267c8249");
      let review = prompt("Write Review","Review!");
      if(bookId && review){
        fetch("/booksReviews",{
          method : "POST",
          headers : {
            "Content-type" : "application/json"
          },
          body : JSON.stringify({
            bookId,review
          })
        }).then(response=>{
          showToast("Review Updated");
          return fetch("/booksReviews")
        })
        .then(response=>response.json())
        .then(reviews=>{
          this.reviews = reviews;
        });
      } else {
        showToast("Cancelled : Book ID or Review not provided");
      }
    }
  },
};
</script>
