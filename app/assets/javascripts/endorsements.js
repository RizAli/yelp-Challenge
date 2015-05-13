
$(document).ready(function() {

  $('.endorsements-link').on('click', function(event){
      event.preventDefault();
      alert("hello")
      var endorsementCount = $(this).siblings('.endorsements_count');

      $.post(this.href, function(response){
        endorsementCount.text(response.new_endorsement_count);
    })
  })
})