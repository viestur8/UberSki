<div class="card col" style="width: 18rem;">
  <div class="card-body">
  <img class="card-img-top col" src="https://www.sciencesource.com/Doc/SCS/Media/TR1_WATERMARKED/0/7/d/4/SS2562935.jpg?d63642764426" alt="Card image cap">
  <h5 class="card-title"> <%= @user.title %> </h5>
    <p class="card-text"> <%= @user.post %> </p>
    <h6> <%= @user.user_id %> </h6>
    <a href="/users/<%= @user.post %>" class="btn btn-primary">Your Profile</a>
    <a href="/users/<%= @user.id %>/edit" class="btn btn-secondary">Edit</a>
    </div>
  </div>
