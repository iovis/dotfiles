local u = require("config.utils")

return {
  -- .clang-format
  s(
    "clangformat",
    fmta(
      [[
        BasedOnStyle: LLVM
        ColumnLimit: 120

        AllowShortFunctionsOnASingleLine: None
        AllowShortIfStatementsOnASingleLine: WithoutElse
        AllowShortLoopsOnASingleLine: true
        BreakAfterReturnType: None
        PenaltyReturnTypeOnItsOwnLine: 1000

        AlignAfterOpenBracket: BlockIndent
        AllowAllArgumentsOnNextLine: false
        AllowAllParametersOfDeclarationOnNextLine: false
        BinPackArguments: false
        BinPackParameters: false
        BreakBeforeBinaryOperators: All
      ]],
      {}
    ),
    {
      show_condition = u.ls.within(".clang-format"),
      condition = conds.line_begin * u.ls.within(".clang-format"),
    }
  ),
}
