Swap Stores
===========

iOS Demo Project to illustrate hot-swapping Core Data store files.


Usage
=====

This project is based on the Utlility Project in Xcode with Core Data enabled. We're not using the UI, all output is printed as log messages.

Most of the action takes place in MainViewController which contains several methods:

* createSomeData: creates 10 managed objects and saves them to a store file
* showData: basic fetch request that prints out all fetched objects
* swapStores: switches out store1 and repalces it with store2

You must create the two store files manually upon first run.

http://pinkstone.co.uk/how-to-swap-out-a-store-file-in-core-data/
