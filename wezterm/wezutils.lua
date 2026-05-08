local wezterm = require 'wezterm'
local mux = wezterm.mux
local wezutils = {}

--[[
-- sample: project_table
{
  -- workspaces
  ["daily"] = {
    -- tabs
    {
      title = "hoge",
      cwd = "~/Development/hoge/"
    },
    {
      title = "FantiaContainer",
      cwd = "~/Development/hoge/",
      panes = {
        { text = "docker compose exec fantia bash\n" },
        { split = { direction = "Bottom", size = 0.4 } },
        { split = { direction = "Right", size = 0.4 } },
      }
    },
    {
      title = "dotfiles",
      cwd = "~/dotfiles"
    }
  }
}
--]]
function wezutils.startup(project_table)
  local conf = project_table or {}

  wezterm.on('mux-startup', function()
    -- local tab, pane, window = mux.spawn_window {}
    -- pane:split { direction = 'Top' }
  end)
end

return wezutils

--[[
-- 参考
function M.startup(project_name)
  local project_config = M.projects[project_name]
  if not project_config then
    wezterm.log_error("Project not found: " .. project_name)
    return
  end

  -- 最初のタブ設定を取得
  local first_tab_config = project_config[1]
  
  -- 1. ウィンドウと最初のタブ、ペインを作成 (Workspace名を指定)
  local tab, pane, window = mux.spawn_window {
    workspace = project_name,
    cwd = first_tab_config.cwd,
  }
  
  -- 最初のタブのタイトル設定
  tab:set_title(first_tab_config.title)

  -- タブごとのループ処理
  for i, tab_conf in ipairs(project_config) do
    local current_tab = tab
    local current_pane = pane

    -- 2つ目以降のタブなら新規作成
    if i > 1 then
      current_tab, current_pane, _ = window:spawn_tab {
        cwd = tab_conf.cwd
      }
      current_tab:set_title(tab_conf.title)
    end

    -- ペインごとのループ処理
    if tab_conf.panes then
      -- 最初のペインはタブ生成時に既に作られているので、変数に入れておく
      local panes_in_tab = { current_pane }

      for j, pane_conf in ipairs(tab_conf.panes) do
        local working_pane

        if j == 1 then
          -- 1つ目のペインは既存のものを使う
          working_pane = panes_in_tab[1]
        else
          -- 2つ目以降は分割して作成
          -- 直前のペイン(panes_in_tab[#panes_in_tab])に対して分割を行う例
          local parent_pane = panes_in_tab[j-1]
          
          working_pane = parent_pane:split {
            direction = pane_conf.split and pane_conf.split.direction or "Right",
            size = pane_conf.split and pane_conf.split.size or 0.5,
            cwd = tab_conf.cwd -- タブと同じcwdを引き継ぐ
          }
          table.insert(panes_in_tab, working_pane)
        end

        -- コマンド送信
        if pane_conf.text then
          working_pane:send_text(pane_conf.text)
        end
      end
    end
  end
  
  -- 作成したWorkspaceにフォーカスを切り替える
  mux.set_active_workspace(project_name)
end

return M
--]]
