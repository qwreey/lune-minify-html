local minify_html = require("./")
	.new(require("@lune/process").args[1] or "./target/release/liblune_minify_html.so")

local result = minify_html:minify([[
	<html>
		<html>
			<title>Hello world</title>
		</html>
		<body>
			<p>Hello world</p>
		</body>
	</html>
]])

print(result) -- <title>Hello world</title></html><body><p>Hello world
