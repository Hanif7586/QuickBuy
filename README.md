# quickbuy

A new Flutter project.
Title:
QuickBuy - Simplified Online Shopping

Description:
QuickBuy is your one-stop solution for fast, easy, and secure online shopping. Browse through a wide range of products, enjoy personalized recommendations, and complete your purchase in just a few clicks. With seamless navigation, secure payments, and instant order tracking, QuickBuy makes shopping a breeze, whether you're at home or on the go. Shop smart, shop fast with QuickBuy!
Key Features:
User-Friendly Interface:

Intuitive navigation and search functionalities for a seamless shopping experience.
Personalized Recommendations:

Smart algorithms that suggest products based on user preferences and shopping history.
Quick Checkout:

One-click checkout for fast transactions, saving users time and effort.
Secure Payments:
Product category 
Order System
Searview
Get all products
By default you will get 30 items, use Limit and skip to paginate through all items.

Json:
fetch('https://dummyjson.com/products')
.then(res => res.json())
.then(console.log);
Get a single product
fetch('https://dummyjson.com/products/1')
.then(res => res.json())
.then(console.log);
Search products
fetch('https://dummyjson.com/products/search?q=phone')
.then(res => res.json())
.then(console.log);
