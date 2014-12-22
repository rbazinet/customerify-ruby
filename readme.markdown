# Customerify

A ruby client for the [Customerify.com](http://customerify.com) [event API](https://customerify.com/api/docs/index.html).

## Installation

Add this line to your application's Gemfile:

    gem 'customerify'

And then execute:

    $ bundle

Or install it yourself:

    $ gem install customerify

## Usage

In your code, create an instance of the client using your Account identifier and your API key:

    client = Customerify::Client.new your_account_identifier, your_api_key
    
Then you can start tracking your events but using the correct event descriptor and passing the info in the option keys _description_, _content_, and (if e-mail is involved) _recipients_ list.
The recipients list can be a string or an array, so either you can:

    recipient_list = "user1@mail.com, user2@mail.com, user.n@mail.com"
    
or:

    recipient_list = ["user1@mail.com", "user2@mail.com", "user.n@mail.com"]

and the api call method will look like follows:

    client.track descriptor_name, description: 'description string', content: 'content text', recipients: recipients_list

The result is an HTTP::Response instance with the info from the transaction

