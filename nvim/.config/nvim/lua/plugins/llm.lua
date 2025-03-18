local function local_llm_streaming_handler(chunk, ctx, F)
  if not chunk then
    return ctx.assistant_output
  end
  local tail = chunk:sub(-1, -1)
  if tail:sub(1, 1) ~= "}" then
    ctx.line = ctx.line .. chunk
  else
    ctx.line = ctx.line .. chunk
    local status, data = pcall(vim.fn.json_decode, ctx.line)
    if not status or not data.message.content then
      return ctx.assistant_output
    end
    ctx.assistant_output = ctx.assistant_output .. data.message.content
    F.WriteContent(ctx.bufnr, ctx.winid, data.message.content)
    ctx.line = ""
  end
  return ctx.assistant_output
end

local function local_llm_parse_handler(chunk)
  local assistant_output = chunk.message.content
  return assistant_output
end

return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler" },
    config = function()
      local tools = require("llm.tools")
      require("llm").setup({

        prompt = "You are a helpful chinese assistant.",
        spinner = {
          text = {
            "󰧞󰧞",
            "󰧞󰧞",
            "󰧞󰧞",
            "󰧞󰧞",
          },
          hl = "Title",
        },
        prefix = {
          -- 
          user = { text = "😃 ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        url = "http://localhost:11434/api/chat", -- your url
        model = "qwen2.5-coder:0.5b",

        streaming_handler = local_llm_streaming_handler,
        app_handler = {
          WordTranslate = {
            handler = tools.flexi_handler,
            prompt = "Translate the following text to Chinese, please only return the translation",
            opts = {
              parse_handler = local_llm_parse_handler,
              exit_on_move = true,
              enter_flexible_window = false,
            },
          },
        },
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"] = { mode = "n", key = "<cr>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },
        },
      })
    end,
    keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Open LLM Session" },
      {
        "<leader>ae",
        mode = "v",
        "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>",
        desc = "Code explanation",
      },
      {
        "<leader>t",
        mode = "x",
        "<cmd>LLMSelectedTextHandler 英译汉<cr>",
        desc = "English-Chinese translation",
      },
    },
  },
}
