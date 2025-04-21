const std = @import("std");
const String = []const u8;
const List = []const []const u8;
const Fixes = enum { Pre, Suf };

const plugin_path = "plugins";

const plugins = [_]String{
    "MunifTanjim/nui.nvim",
    "SmiteshP/nvim-navbuddy",
    "SmiteshP/nvim-navic",
    "altermo/ultimate-autopair.nvim",
    "andersevenrud/nvim_context_vt",
    "folke/flash.nvim",
    "folke/snacks.nvim",
    "gbprod/substitute.nvim",
    "hadronized/hop.nvim",
    "kylechui/nvim-surround",
    "niuiic/core.nvim",
    "niuiic/track.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/oil.nvim",
    "utilyre/sentiment.nvim",
    "vim-jp/nvimdoc-ja",
    "vim-jp/vimdoc-ja",
    "zbirenbaum/copilot.lua",
    "sphamba/smear-cursor.nvim",
    "neovim/neovim",
};

pub fn build(b: *std.Build) void {
    const plug_sync_step = b.step("plug-sync", "sync plugins");
    _ = .{ b, plug_sync_step };
}

fn addFix(comptime fix: Fixes) fn (comptime String) fn (comptime List) List {
    const cat = struct {
        fn f(comptime nfix: String, comptime str: String) String {
            return switch (fix) {
                .Pre => nfix ++ str,
                .Suf => str ++ nfix,
            };
        }
    }.f;

    return struct {
        fn f(
            comptime nfix: String,
        ) fn (comptime List) List {
            return struct {
                fn f(comptime srcs: List) List {
                    var ret: [srcs.len]String = undefined;
                    inline for (srcs, 0..) |src, i| {
                        ret[i] = cat(nfix, src);
                    }
                    return &ret;
                }
            }.f;
        }
    }.f;
}

test "add prefix" {
    try std.testing.expectEqualSlices(
        u8,
        "plugins/neovim/neovim",
        addFix(.Pre)("plugins/")(&[_]String{"neovim/neovim"})[0],
    );
}
