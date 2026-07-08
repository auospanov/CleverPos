namespace CleverApp
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            if (Configuration.AppConfig.EnableShopMode)
                return new Window(new AppShell());

            Page root = Services.VisitorJournal.VisitorSessionStore.IsAuthenticated
                ? new NavigationPage(new VisitorHomePage())
                : new NavigationPage(new LoginPage());

            return new Window(root);
        }
    }
}