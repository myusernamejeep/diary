appRouter = new AppRouter()
progress = new SubscriptionProgress()
progressView = new SubscriptionProgressTemplateHelper(progress)

articlesPagination = new ArticlesPagination(progress)

Meteor.startup ->

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_ONLY'


  progress.addSubscription (subscribe) =>
    subscribe 'tags'
        
  progress.registerInitialLoadHandler(->
    Meteor._debug "#{progress.getSubscriptionCount()} subscriptions loaded initially"
    Backbone.history.start({pushState: true})

    if Backbone.history.fragment is ""
      appRouter.navigate "/l", trigger: true

  )  