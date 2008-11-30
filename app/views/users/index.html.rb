<% title "Users" %>

<% for user in @users %>

<% end %>

<% if logged_in? == false %>
    <%= link_to "New user", new_user_path %>
<% end %>

