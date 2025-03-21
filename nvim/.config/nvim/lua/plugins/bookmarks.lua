return {
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      { '<leader>ma', '<cmd>MarksListAll<CR>' },
      { '<leader>mb', '<cmd>MarksListBuf<CR>' },
      { '<leader>mg', '<cmd>MarksListGlobal<CR>' },
    },
  },
}
