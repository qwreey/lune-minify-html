--!nolint TableOperations

local ffi = require("@lune/ffi")

export type minify_html = minify_html_pub & minify_html_private

export type minify_html_pub = {}
export type minify_html_private = {
	_lib: ffi.LibData,
	_minify: ffi.CallableData,
}

local minify_html = {} :: minify_html
minify_html.__index = minify_html

local minify_result = ffi.c.struct({
	-- len
	ffi.i32,
	-- ptr
	ffi.c.char:ptr(),
})

function minify_html.new(lib_path: string): minify_html
	local self = setmetatable({}, minify_html)
	self._lib = ffi.open(lib_path)
	self._minify = ffi.c.fn({ ffi.u8:ptr(), ffi.i32 }, minify_result):callable(self._lib:find("minify"))
	return self
end

function minify_html:minify(code: string): string
	local result = ffi.box(minify_result.size)
	local source = ffi.box(#code):writeString(code)
	self._minify(result, source:ref():ref(), ffi.i32:box(#code):ref())
	local result_table = minify_result:readData(result)
	local result_string = result_table[2]:readString(result_table[1])
	ffi.free(result_table[2])
	if result_table[3] == 1 then
		error(result_string)
	end
	return result_string
end

return minify_html :: { new: (lib_path: string) -> minify_html }
