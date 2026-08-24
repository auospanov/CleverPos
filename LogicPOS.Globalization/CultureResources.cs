using System.Resources;

namespace LogicPOS.Globalization
{
    public static class CultureResources
    {
        private static ResXResourceSet ResourceSet { get; set; }

        private static string GetResourcesFileByName(string resourceName)
        {
            return $"Resources\\Localization\\{resourceName}";
        }

        private static string GetDefaultLanguage()
        {
            return System.Configuration.ConfigurationManager.AppSettings["customCultureResourceDefinition"].ToString();
        }

        private static void UpdateResourceSetByLanguage(string language)
        {
            switch (language)
            {
                case "en-GB":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.en-GB.resx"));
                    break;
                case "en-US":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.en-US.resx"));
                    break;
                case "fr-FR":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.fr-FR.resx"));
                    break;
                case "pt-BR":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.pt-BR.resx"));
                    break;
                case "pt-AO":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.pt-AO.resx"));
                    break;
                case "pt-MZ":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.pt-MZ.resx"));
                    break;
                case "pt-PT":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.pt-PT.resx"));
                    break;
                case "es-ES":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.es-ES.resx"));
                    break;
                case "ru-RU":
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.ru-RU.resx"));
                    break;
                default:
                    ResourceSet = new ResXResourceSet(GetResourcesFileByName("Resx.resx"));
                    break;
            }
        }

        /// <summary>
        /// Resolve a localized string. Never throws — missing keys fall back to pt-PT, then Resx.resx, then null.
        /// </summary>
        public static bool TryGetResourceByLanguage(string language, string resourceName, out string resourceValue)
        {
            resourceValue = null;
            if (string.IsNullOrEmpty(resourceName))
            {
                return false;
            }

            if (ResourceSet == null)
            {
                if (string.IsNullOrEmpty(language))
                {
                    language = GetDefaultLanguage();
                }

                UpdateResourceSetByLanguage(language);
                System.Diagnostics.Debug.WriteLine($"GetResourceByLanguage: ResourceSet loaded for language {language}");
            }

            resourceValue = ResourceSet.GetString(resourceName);
            if (resourceValue != null)
            {
                return true;
            }

            System.Diagnostics.Debug.WriteLine($"GetResourceByLanguage: Resource {resourceName} not found in {language} language, trying fallbacks");

            var ptSet = new ResXResourceSet(GetResourcesFileByName("Resx.pt-PT.resx"));
            resourceValue = ptSet.GetString(resourceName);
            if (resourceValue != null)
            {
                return true;
            }

            var baseSet = new ResXResourceSet(GetResourcesFileByName("Resx.resx"));
            resourceValue = baseSet.GetString(resourceName);
            return resourceValue != null;
        }

        public static string GetResourceByLanguage(string language, string resourceName)
        {
            if (TryGetResourceByLanguage(language, resourceName, out string resourceValue) && resourceValue != null)
            {
                return resourceValue;
            }

            // Soft fallback: never crash the app on a missing translation key
            System.Diagnostics.Debug.WriteLine($"GetResourceByLanguage: Resource {resourceName} not found; using key as fallback");
            return resourceName;
        }

        public static void UpdateLanguage(string language)
        {
            UpdateResourceSetByLanguage(language);
        }

        public static void ForceUpdateLanguage(string language)
        {
            // Принудительно сбрасываем ResourceSet
            ResourceSet = null;

            // Обновляем язык
            UpdateResourceSetByLanguage(language);

            // Отладочная информация
            System.Diagnostics.Debug.WriteLine($"ForceUpdateLanguage: Language set to {language}");
        }
    }
}
