# In-Memory Data Store

| Note: This project was a solution to a technical assessment prompt which can be found in the `docs` directory.

A ruby gem to create an in-memory data store with repl

## Requirements

* Ruby Version 2.7.2
* Bundler Version 2.2.16
* RubyGems Version 3.2.11

## Getting Started

From the project root you may begin installation and use.

### Installation

`bundle install`

### Running the project

To start the in memory database run the `imds` command found in the `bin` directory.

```bash
$ bin/imds
```

This command starts the in-memory server and drops you into an interactive prompt. From this prompt you can issue supported commands to the database.

### Commands

| Command Name | Arguments | Description |
| ------------ | --------- | ----------- | 
| SET | name, value | Set the value for database entry at key name|
| GET | name | Get the value for the database entry at key name |
| DELETE | name | Delete the entry at key name |
| COUNT | value | Print the number of keys with matching value |
| END | | Exit the database

### Advanced Commands

| Command Name | Arguments | Description |
| ------------ | --------- | ----------- | 
| BEGIN | | Start a new transaction |
| ROLLBACK | | Rollback the last transaction  |
| COMMIT | | Commit all open transactions |


### Example

More information can be found in the technical prompt pdf in the `docs` directory.

```
>> GET foo
NULL
>> SET bar test
>> GET bar
test
>> BEGIN
>> DELETE bar
>> SET foo hello
>> GET bar
NULL
>> ROLLBACK
>> GET bar
test
>> GET foo
NULL
```
## Running Tests

`bin/rspec`

## Notes

Although a Rakefile exists, running the rake task `start` current does not work. This was a nice to have that was left to finish later.
