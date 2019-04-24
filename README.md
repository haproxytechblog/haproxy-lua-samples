# HAProxy Lua Samples

Examples of extending HAProxy using Lua. These extension points are available:

* Actions
* Converters
* Fetches
* Services
* Tasks

## Usage

Check that you have Lua compiled into HAProxy:

```
$ haproxy -vv | grep Lua
Built with Lua version : Lua 5.3.5
```

Copy each sample into **/etc/haproxy** and update your **haproxy.cfg** file. Use the `lua-load` directive in your configuration to include a Lua file.