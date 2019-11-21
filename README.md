#  WayvRoll README

To run:

* bundle install

* yarn install

* rails db:create

* rails db:migrate

* bin/webpack-dev-server

* rails s

Points of Pride:

* Separation of concerns - I have kept the controllers clean of extraneous logic by leveraging modules that are themselves governed by the principle of separation of concerns. Generally, one function is called from the controller with cascading functions being called in the module to complete the desired operation. This makes keeping the code DRY in the future easier and makes the code base more maintainable. The vue components and their logic is also organized in a logical way. 

* Readable code - the functions in the modules have descriptive titles and are designed to accomplish one thing at a time. I live by the mantra that a function should do one thing and that it should do that thing well. The combination of descriptive naming conventions, the cascading organization of functions and the scoping of a behavior to a function makes readable and therefore easier for the next developer to understand and work on. 

* The Wages Problem - I decided to go a more complex route and not hardcode the wage of the job group into the app because I would want users to be able to alter that information and create new job groups in the future. This presented a problem, in order to calculate the total amount paid for a pay period that information would have to be available. But instead of forcing users to go in and create job groups manually, I set it up so that when a CSV is uploaded and submitted, the group names are sent to the back end, checked, and if they don't exist, prompts the user to enter the wages and then submits the csv to be parsed and organized. I decided not to default to 0 on wage group in the creation of a new job group because the rows themselves are not editable, and report_ids are unique preventing the user from resubmitting them. Better to throw an error and reset the form than have bad, uneditable information in the database and accessible to the user. All attempts were made for ease of use in this regard.

* Front end - I built a pretty dynamic front end (mostly) in Vue.js, and I am pretty happy with the courses index. You can filter reports by name, and get a pretty rich data set about users, wages and other money related info with no page loads and lean code, you can also sort the table using the buttons at the top by whatever column you want and in whatever direction (ascending and descending), if I had more time I would have made it so that you could sort by more than one option at a time. I also scoped all previous information submitted about an employee and put it in a table on the employee show page. 

* Scalable - I avoided making any direct N+1 queries using eager loading where applicable and avoided using deeply nested loops. I think the exception is in the report organizer module, but the initial loop is capped at 12 as it is looping through 12 months at most, but given the nature of the application it shouldn't loop through the loops more than 2-3 times unless the user submits a payroll report for a year. I doubt this would be a very common use case. I also tried to make larger queries and then sort them using ruby logic to stop from making extraneous database queries and creating bottlenecks.


