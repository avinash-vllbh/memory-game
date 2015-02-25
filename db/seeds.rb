User.create!([
  {email: "admin@admin.com", :password => 'topsecret', :password_confirmation => 'topsecret', admin: true, first_name: "Avinash", last_name: "Vallabhaneni"}
])
Card.create!([
  {content: "triangle"},
  {content: "square"},
  {content: "circle"},
  {content: "rectangle"},
  {content: "hexagon"},
  {content: "pentagon"},
  {content: "diagonal"},
  {content: "rhombus"},
  {content: "octagon"},
  {content: "sphere"}
])