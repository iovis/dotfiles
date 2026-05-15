local u = require("config.utils")

return {
  -- .clang-format
  s(
    "init",
    fmta(
      [[
        BasedOnStyle: LLVM
        ColumnLimit: 120
        AllowShortIfStatementsOnASingleLine: WithoutElse
        AllowShortFunctionsOnASingleLine: None
        BreakAfterReturnType: None
        PenaltyReturnTypeOnItsOwnLine: 1000

        BinPackArguments: false
        BinPackParameters: false
        AllowAllArgumentsOnNextLine: false
        AllowAllParametersOfDeclarationOnNextLine: false
        AlignAfterOpenBracket: BlockIndent
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
