p 'Deleting the database'

CartItem.destroy_all
Cart.destroy_all
Review.destroy_all
Hair.destroy_all

User.destroy_all

p 'Creating the admin user'

admin_user = User.new(
  first_name: "Patrick",
  last_name: "Amfo",
  date_of_birth: Date.new(1995, 6, 20),
  phone_number: "0755",
  address: "323 Kennington Lane, London, SE16 2XB",
  email: "junior.amfo@gmail.com",
  password: "password",
  admin: true
)

admin_user.save!

p 'Creating hair'

file = File.open('app/assets/images/SeamlessClipins-BodyWave_74241c2b-1ce7-4508-b7cd-6fa77e420659.jpg')

admin_hair = Hair.new(
  name: "testhair",
  price: 100,
  length: 20,
  texture: "Loose Wave",
  origin: "Brazilian",
  quantity: 100,
)

admin_hair.admin = admin_user
admin_hair.photo.attach(io: file, filename: 'Seamless', content_type:"image/png")
admin_hair.save
p 'Hair and Admin user created'

p 'Creating a review'

Review.create!(
  hair: admin_hair,
  user: admin_user,
  rating: 4.5,
  comment: "good hair"
)

p 'Creating a cart and CartItem'

# Create the Cart. If you've already auto-created a cart via a callback, you can use admin_user.cart instead.
admin_cart = Cart.create!(user: admin_user, total: admin_hair.price.to_i)

# Create a CartItem for the only Brazilian hair with quantity 1
CartItem.create!(cart: admin_cart, hair: admin_hair, quantity: 1)

p 'Review, Cart, and CartItem created'
