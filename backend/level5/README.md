## Instructions

First run
`bundle install`

Then
`ruby main.rb`

If your want to run the tests run from here
`rspec specs/*.spec.rb`

# Level 5

We want to know how much money must be debited/credited for each actor (driver/owner/insurance/assistance/drivy).

Reminder:
- the driver must pay the rental price and the (optional) deductible reduction
- the owner receives the rental price minus the commission
- the insurance receives its part of the commission
- the assistance receives its part of the commission
- drivy receives its part of the commission, plus the deductible reduction
