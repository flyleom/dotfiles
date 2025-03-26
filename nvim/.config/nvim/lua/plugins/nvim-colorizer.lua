return {
  "norcalli/nvim-colorizer.lua",
  event = "BufRead", -- 当读取文件时自动加载，也可以根据需要改为其他事件
  config = function()
    require("colorizer").setup({
      -- 可以在这里配置针对不同文件类型的选项，例如：
      "*", -- 所有文件都启用
      css = { rgb_fn = true }, -- CSS 文件启用 rgb() 函数解析
      -- html = { names = false }, -- HTML 文件禁用颜色名字解析
    }, {
      mode = "background", -- 默认使用背景色高亮
    })
  end,
}
