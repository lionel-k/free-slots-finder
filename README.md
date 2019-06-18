## Free Slots Finder

This app can help you find the available slots from 2 agendas containing busy slots with this format.

```
[
  {
    start: datetime,
    end: datetime
  },
  {
    start: datetime,
    end: datetime
  },
  ...
]
```

To Run the script:

1. Open `lib/main.rb`
2. Add the busy slots on this format in Sandra and Andrews busy slots arrays.

  ```ruby
  {
    start: DateTime.new(2019, 6, 20, 9, 30),
    end: DateTime.new(2019, 6, 20, 9, 40)
  }
  ```
3. Run in command line
```shell
ruby lib/main.rb
```

To run the spec:

```shell
  rspec
```
