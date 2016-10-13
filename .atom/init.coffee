# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

process.env.PATH = ["/usr/local/bin", "/Users/david/.node/bin", "/Users/david/.rbenv/shims", process.env.PATH].join(":")

atom.commands.add 'atom-text-editor',
  'user:semicolonizeNoNL', ->
    editor = @getModel()
    editor.moveToEndOfLine()
    editor.insertText(";", {'.autoIndentNewline': true})

atom.commands.add 'atom-text-editor',
  'user:semicolonize', ->
      editor = @getModel()
      atom.commands.dispatch(atom.views.getView(editor), 'user:semicolonizeNoNL')
      editor.insertNewline()

atom.commands.add 'atom-text-editor',
  'user:arrow', ->
    editor = @getModel()
    editor.insertText("->")

atom.commands.add 'atom-text-editor',
  'user:arrowEOL', ->
    editor = @getModel()
    editor.moveToEndOfLine()
    atom.commands.dispatch(atom.views.getView(editor), 'user:arrow')

atom.commands.add 'atom-text-editor',
  'user:fatarrow', ->
    editor = @getModel()
    editor.insertText(" => ")
