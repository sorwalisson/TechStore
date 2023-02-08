This is a under construction project.
It will be a E-commerce API, built in rails 7.0.4, ruby 3.1.2
Gems used 
Active model serializer 0.10.0, Devise and the standard develop kit, like byebug, rspec and factory_bot


The Object Product stores the product sold.

The Item model is the bridge between the product sold and the Cart and Orders model.

Which means that orders and carts has_many :products, through: :items

Each Product also has one Stock, which stores the amount of product available to sell, and also how many has been sold.

Each User has one Cart, which then, will have the Items stored transfered to a new Order when the Users decides to buy the products.

and after a Order is done, it will send it values to the finance so the store can see how much they profit, tax amounts and etc.

after user recieve the item the user can Review the item. (under construction)

The project is on going, so lots of features needs to be build.


Cheers
Walisson.





