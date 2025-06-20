# # 
# # print("hello")
# # 
# # print(getwd())
# # getwd()
# # setwd("_site")
# 
# library(httr)
# 
# custom <- F
# 
# # here::i_am("wtm_gb.Rproj")
# 
# source(here::here("cntry.R"))
# 
# 
# # print("hello")
# 
# sets <- jsonlite::fromJSON("settings.json")
# 
# # sets$cntry <- "NP"
# 
# 
# # sets$cntry <- "AD"
# 
# options(scipen = 999)
# 
# 
# # wtm_data %>% count(party,sort = T)
# 
# 
# # sources("here::here(party_utils.R")
# setColors <- function(df) {
#   # Check if the 'color' column exists
#   if (!"color" %in% names(df)) {
#     df <- df %>% mutate(color = NA)
#   }
#   
#   # Function to generate a random color
#   generateRandomColor <- function() {
#     sprintf("#%06X", sample(0:16777215, 1)) # Generates a random hex color
#   }
#   
#   # Apply the function to each row
#   df$color <- sapply(df$color, function(color) {
#     if (is.na(color) || nchar(color) < 5) {
#       return(generateRandomColor())
#     } else {
#       return(color)
#     }
#   })
#   
#   return(df)
# }
# 
# country_codes <- c("AD", "AL", "AM", "AR", "AT", 
#                    "AU", "BA", "BE", "BG", "BR", 
#                    "CA", "CH", "CL", "CO", "CY", 
#                    "CZ", "DE", "DK", "EC", "EE", 
#                    "ES", "FI", "FR", "GB", "GR", 
#                    "GT", "HR", "HU", "IE", "IN", 
#                    "IS", "IT", "LI", "LT", "LU", 
#                    "LV", "MD", "ME", "MK", "MT",
#                    "MX", "NL", "NO", "NZ", "PL", 
#                    "PT", "RO", "RS", "SE", "SI", 
#                    "SK", "SM", "TR", "UA", "US", 
#                    "VE", "ZA")
# 
# 
# # try({
# #   download.file(paste0("https://data-api.whotargets.me/advertisers-export-csv?countries.alpha2=", str_to_lower(sets$cntry)), destfile = "data/wtm_advertisers.csv")
# #   
# #   thedat <- read_csv(here::here("data/wtm_advertisers.csv")) %>% 
# #     filter(entities.short_name != "ZZZ") 
# #   
# # })
# # 
# # if(!exists("thedat")){
# #   thedat <- tibble(no_data = NULL)
# # }
# 
# 
# library(tibble)
# 
# wtm_labs <- readRDS("../data/wtm_labs.rds")
# 
# thhone <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTSSh_8rDUFjkmabJRsRHit5BGjtOovd6pAE63_EeB9SqCtKojaewmSoCyu2re43eQ5iX6CVz68-l_N/pub?output=csv")
# 
# 
# if(sets$cntry == "EU"){
#   
#   color_dat <- tibble(
#     party = c("ECR", "EPP", "GUE/NGL", "Greens/EFA", "ID", "InneEP", "RE", "S&D"),
#     colors = c("#0033A0", "#3399FF", "#b71c1c", "#33CC33", "#0e408a", "#999999", "#FFCC00", "#f0001c")
#   )
#   
#   saveRDS(color_dat, here::here("data/color_dat.rds"))
#   
# 
#   wtm_labs_fin <- wtm_labs %>% 
#     mutate(European_Political_Group2 = ifelse(entities_groups.group_name == "Group 4", entities.short_name, NA)) %>% 
#     left_join(thhone) %>% 
#     rename(party = European_Political_Group) %>% 
#     mutate(party = ifelse(is.na(party), European_Political_Group2, party)) %>% 
#     mutate(party = ifelse(party %in% c("-", "uncertain") | is.na(party), "-", party))
#   
#   
#   
#   
#   election_dat30 <- readRDS("../data/election_dat30.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party, national_party = entities.short_name)) %>% 
#     mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     filter(party %in% color_dat$party)
#   
#   election_dat7 <- readRDS("../data/election_dat7.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party, national_party = entities.short_name)) %>% 
#     mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     filter(party %in% color_dat$party)
#   
#   
#   most_left_party <- "Greens/EFA"
#   
# } else if(sets$cntry == "NL"){
#   
#   color_dat <- tibble(
#     colors = c("#00b13d", "#80c31c", "#0a2cca", "#008067", "#bf0000", "#ff0000", "#6f2421", "#02a6e9", "#92107d", "#04d3d4", "#242b57", "#66cdaa", "#242b57", "#006b28", "#012758", "#ea5b0b", "#582c83", "#698c0c", "#fdfd00", "#8da6d6", "#dc1f26", "#FFD700"),
#     party = c("D66", "GroenLinks", "VVD", "CDA", "SP", "PvdA", "FvD", "ChristenUnie", "50PLUS", "Alliantie", "BVNL", "DENK", "Ja21", "PvdD", "PVV", "SGP", "Volt Nederland", "BBB", "BIJ1", "NSC", "GroenLinks-PvdA", "Libertaire Partij"))
#   
#   saveRDS(color_dat, here::here("data/color_dat.rds"))
#   
#   all_dat <- read_rds("https://github.com/groene/TK2023/raw/main/data/all_dat.rds")
#   
#   wtm_labs_fin <- wtm_labs %>% 
#     mutate(European_Political_Group2 = ifelse(entities_groups.group_name == "Group 4", entities.short_name, NA)) %>% 
#     left_join(thhone) %>% 
#     rename(party = European_Political_Group) %>% 
#     mutate(party = ifelse(is.na(party), European_Political_Group2, party)) %>% 
#     mutate(party = ifelse(party %in% c("-", "uncertain") | is.na(party), "-", party))
#   
#   
#   election_dat30 <- readRDS("../data/election_dat30.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party, national_party = entities.short_name)) %>% 
#     # mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     # mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     mutate(party = national_party) %>% 
#     # filter(party != "-")  %>% 
#     filter(cntry == str_to_upper(sets$cntry)) %>% 
#     left_join(all_dat %>% select(internal_id = page_id, party2 = party)) %>% 
#     mutate(party = ifelse(is.na(party2), party, party2)) %>% 
#     filter(party %in% color_dat$party)
#   
#   election_dat7 <- readRDS("../data/election_dat7.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party, national_party = entities.short_name))%>% 
#     # mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     # mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     mutate(party = national_party) %>% 
#     # filter(party != "-")  %>% 
#     filter(cntry == str_to_upper(sets$cntry)) %>% 
#     left_join(all_dat %>% select(internal_id = page_id, party2 = party)) %>% 
#     mutate(party = ifelse(is.na(party2), party, party2)) %>% 
#     filter(party %in% color_dat$party)
#   
#   
#   most_left_party <- color_dat$party[1]
#   
# }else if(sets$cntry == "DE"){
#   
#   wtm_labs <- read_csv("../data/c4b7f904-acac-45e0-b5c5-75e24ffdb34d.csv.gzip")
#   
#   wtm_labs_fin <- wtm_labs %>% 
#     # mutate(European_Political_Group2 = ifelse(entities_groups.group_name == "Group 4", entities.short_name, NA)) %>%
#     filter(entities_groups.group_name == "Group 1") %>% 
#     # left_join(thhone) %>% 
#     rename(party = entities.short_name,
#            internal_id = advertisers_platforms.advertiser_platform_ref) %>% 
#     mutate(party = case_when(
#       party == "AND" ~ "Others",
#       party == "Sta" ~ "Government",
#       party == "Pol" ~ "Political Actors",
#       party == "Grü" ~ "B90/Die Grünen",
#       party == "Lin" ~ "LINKE",
#       party == "PIR" ~ "Piraten",
#       party == "VOL" ~ "Volt Deutschland",
#       party == "FAM" ~ "Familienpartei",
#       party == "PAR" ~ "Die PARTEI",
#       party == "NPD" ~ "HEIMAT (prev. NPD)",
#       party == "PdH" ~ "Partei der Humanisten",
#       T ~ party
#     )) %>% 
#     filter(!(party %in% c("Government", "Political Actors"))) %>% 
#     filter(name != "Pulse of Europe") %>% 
#     filter(party != "Others")
#   
#   color_dat <- wtm_labs_fin %>% 
#     filter(countries.alpha2 == str_to_lower(sets$cntry)) %>% 
#     select(party, color  = entities.color) %>% 
#     distinct() %>% 
#     setColors() %>% 
#     rename(colors = color) %>% 
#     mutate(party = case_when(
#       party == "AND" ~ "Others",
#       party == "Sta" ~ "Government",
#       party == "Pol" ~ "Political Actors",
#       party == "Grü" ~ "B90/Die Grünen",
#       party == "Lin" ~ "LINKE",
#       party == "PIR" ~ "Piraten",
#       party == "VOL" ~ "Volt Deutschland",
#       party == "FAM" ~ "Familienpartei",
#       party == "PAR" ~ "Die PARTEI",
#       party == "NPD" ~ "HEIMAT (prev. NPD)",
#       party == "PdH" ~ "Partei der Humanisten",
#       T ~ party
#     )) %>% 
#     filter(!(party %in% c("Government", "Political Actors")))   %>% 
#     filter(party != "Others")
#   
#   saveRDS(color_dat, here::here("data/color_dat.rds"))
#   
#   election_dat30 <- readRDS("../data/election_dat30.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party)) %>% 
#     # mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     # mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     # mutate(party = national_party) %>% 
#     # filter(party != "-")  %>%
#     filter(cntry == str_to_upper(sets$cntry)) %>% 
#     filter(party %in% color_dat$party)
#   
#   election_dat7 <- readRDS("../data/election_dat7.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party)) %>% 
#     # mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     # mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     # mutate(party = national_party) %>% 
#     # filter(party != "-")  %>%
#     filter(cntry == str_to_upper(sets$cntry)) %>% 
#     filter(party %in% color_dat$party)
#   
#   most_left_party <- color_dat$party[1]
#   
# } else if(sets$cntry != "EU"){
#   
#   wtm_labs_fin <- wtm_labs %>% 
#     mutate(European_Political_Group2 = ifelse(entities_groups.group_name == "Group 4", entities.short_name, NA)) %>% 
#     left_join(thhone) %>% 
#     rename(party = European_Political_Group) %>% 
#     mutate(party = ifelse(is.na(party), European_Political_Group2, party)) %>% 
#     mutate(party = ifelse(party %in% c("-", "uncertain") | is.na(party), "-", party))
#   
#   color_dat <- wtm_labs_fin %>% 
#     filter(countries.alpha2 == str_to_lower(sets$cntry)) %>% 
#     select(party = entities.short_name, color  = entities.color) %>% 
#     distinct() %>% 
#     setColors() %>% 
#     rename(colors = color)
#   
#   saveRDS(color_dat, here::here("data/color_dat.rds"))
# 
#   election_dat30 <- readRDS("../data/election_dat30.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party, national_party = entities.short_name)) %>% 
#     mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     # mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     mutate(party = national_party) %>% 
#     filter(party != "-")  %>%
#     filter(cntry == str_to_upper(sets$cntry)) %>% 
#     filter(party %in% color_dat$party)
#   
#   election_dat7 <- readRDS("../data/election_dat7.rds")  %>% 
#     as_tibble() %>% 
#     select(-party) %>% 
#     left_join(wtm_labs_fin %>% select(internal_id, party, national_party = entities.short_name)) %>% 
#     mutate(party = ifelse(is.na(party), "-", party)) %>% 
#     # mutate(national_party = ifelse(party == "-", "-", national_party))%>% 
#     mutate(party = national_party) %>% 
#     filter(party != "-") %>%
#     filter(cntry == str_to_upper(sets$cntry)) %>% 
#     filter(party %in% color_dat$party)
#   
#   most_left_party <- color_dat$party[1]
#   
#   
# }
# 
#   
#   
# # } 
# 
# 
# 
# scale_fill_parties <- function(...){
#   ggplot2:::manual_scale(
#     'fill',
#     values = setNames(color_dat$colors, color_dat$party),
#     ...
#   )
# }
# scale_color_parties <- function(...){
#   ggplot2:::manual_scale(
#     'color',
#     values = setNames(color_dat$colors, color_dat$party),
#     ...
#   )
# }
# 
# # print("hello")
# 
# # if(custom){
# #   election_dat30 <- readRDS(here::here("data/election_dat30.rds"))  %>% 
# #     select(-contains("party")) %>%
# #     left_join(all_dat %>% distinct(page_id, party))
# #   
# #   election_dat7 <- readRDS(here::here("data/election_dat7.rds"))  %>% 
# #     select(-contains("party")) %>%
# #     left_join(all_dat %>% distinct(page_id, party))
# # }
# 
# 
# # print(glimpse(election_dat30))
# 
# 
# # election_dat30test <<- election_dat30
# 
# # saveRDS(election_dat30, "here::here(data/election_dat30.rds")
# # saveRDS(election_dat7, "here::here(data/election_dat7.rds")
# 

# 
# 
# only_keep_these30 <- election_dat30 %>% 
#   count(internal_id, cntry) %>% 
#   add_count(internal_id, sort = T) %>% 
#   distinct(internal_id, .keep_all = T) %>% 
#   select(-n, -contains("nn"))
# 
# only_keep_these7 <- election_dat7 %>% 
#   count(internal_id, cntry) %>% 
#   add_count(internal_id, sort = T) %>% 
#   distinct(internal_id, .keep_all = T) %>% 
#   select(-n, -contains("nn"))
# 
# 
# election_dat30 <- election_dat30 %>% 
#   filter(party != "Dismissed") %>% 
#   filter(party != "Inv")# %>% 
#   # mutate(total_spend_formatted = euro_spend) %>% 
#   # inner_join(only_keep_these30)
# 
# election_dat7 <- election_dat7 %>% 
#   filter(party != "Dismissed") %>% 
#   filter(party != "Inv")# %>% 
#   # mutate(total_spend_formatted = euro_spend) %>% 
#   # inner_join(only_keep_these7)
# 
# # if(nrow(election_dat30)!=0){
# #   
# #   the_currency <- election_dat30 %>%
# #     count(main_currency, sort = T) %>%
# #     slice(1) %>%
# #     pull(main_currency)
# #   
# #   currency_symbol <- priceR::currency_info %>% 
# #     filter(iso_code == the_currency) %>% 
# #     pull(symbol)
# #   
# #   if(is.null(currency_symbol)){
# #     currency_symbol <- the_currency
# #   }
# #   
# # }

all_dat <- readRDS("../data/all_data.rds")

# readRDS("data/all_data.rds") %>% count(entities_groups.group_name)

# all_dat <- readRDS("../data/all_data.rds") %>%
#   filter(str_detect(entities_groups.group_name, "Parties"))

# all_dat %>% count(party)

# readRDS("data/all_data.rds") %>% count(entities_groups.group_name)

# all_dat %>% count(entities_groups.group_name)

classified_advertisers <- all_dat  %>% 
  select(page_id = advertisers_platforms.advertiser_platform_ref, page_name = advertisers_platforms.advertiser_platform_name, classification = entities.name, colo = entities.color) %>%
  distinct(page_id, .keep_all = T)

color_dat <- classified_advertisers %>% distinct(classification, colo) %>% 
  rename(party = classification, colors = colo)

# classified_advertisers <- readr::read_rds("https://github.com/favstats/wtm_au/raw/refs/heads/main/data/all_dat.rds") %>% 
#   select(page_id, page_name, classification = party) %>%
#   distinct(page_id, .keep_all = T) %>% 
#   filter(classification != "unknown")


election_dat30 <- readRDS("../data/election_dat30.rds")  %>% 
  as_tibble() %>% 
  select(-party) %>%
  # left_join(classified_advertisers %>% select(page_id, party = classification)) %>% 
  filter(is.na(no_data)) %>% 
  left_join(all_dat %>% select(page_id, party, entities.name)) %>%
  drop_na(party) %>%
  mutate(internal_id = page_id) %>%
  filter(!(party %in% c("Others","And", "AND", "Reg", "Oth", "Gov", "Sta", "Inv", "Pol", "Company", "Other Political Party","Government Institution","Independent", "Media Organization", "NGO/Civil Society","Unknown", "Government", "Federal Government", "FedGov", "LocGov"))) %>% 
  mutate(party = entities.name) %>%
  filter(str_detect(party, "Climate advocacy|gas advertisers", negate = T)) %>% 
  drop_na(party) %>% 
  mutate(total_spend_formatted = readr::parse_number(as.character(total_spend_formatted))) %>% 
  mutate(total_num_ads = readr::parse_number(as.character(total_num_ads))) %>% 
  mutate(total_spend_pct = as.numeric(total_spend_pct))%>% 
  mutate(num_ads = readr::parse_number(as.character(num_ads)))


# readRDS("data/election_dat30.rds")  %>%
#   as_tibble() %>%
#   select(-party) %>%
#   # left_join(classified_advertisers %>% select(page_id, party = classification)) %>%
#   filter(is.na(no_data)) %>%
#   left_join(all_dat %>% select(page_id, party, entities.name)) %>%
#   drop_na(party) %>%
#   count(entities.name)

# all_dat %>% select(page_id, party, entities.name) %>% count(entities.name)

election_dat7 <- readRDS("../data/election_dat7.rds")  %>%
  as_tibble() %>% 
  select(-party) %>%
  # left_join(classified_advertisers %>% select(page_id, party = classification)) %>% 
  filter(is.na(no_data)) %>% 
  left_join(all_dat %>% select(page_id, party, entities.name)) %>%
  drop_na(party) %>%
  mutate(internal_id = page_id) %>%
  filter(!(party %in% c("Others","And", "AND", "Reg", "Oth", "Gov", "Sta", "Inv", "Pol", "Company", "Other Political Party","Government Institution","Independent", "Media Organization", "NGO/Civil Society","Unknown", "Government", "Federal Government", "FedGov", "LocGov"))) %>% 
  mutate(party = entities.name) %>%
  filter(str_detect(party, "Climate advocacy|gas advertisers", negate = T))  %>% 
  drop_na(party) %>% 
  mutate(total_spend_formatted = readr::parse_number(as.character(total_spend_formatted))) %>% 
  mutate(total_num_ads = readr::parse_number(as.character(total_num_ads))) %>% 
  mutate(total_spend_pct = as.numeric(total_spend_pct))%>% 
  mutate(num_ads = readr::parse_number(as.character(num_ads)))
  




currency_symbol <- "€"

# color_dat <- election_dat30 %>% 
#   mutate(party = entities.name) %>% 
#   distinct(party, entities.color) %>% 
#   rename(colors = entities.color)

# color_dat <- data.frame(
#   party = c("ACP-NPA", "AD", "AG", "ALP", "C", "CLP", "FFP", "Katter", "LNPQ", "LPA", "ONP", "Reason", "United Australia Party"),
#   colors = c("#006644",  # ACP-NPA (Agrarian/Nationalist - Green)
#              "#BFDA01",  # AD (Liberal/Gold)
#              "#3F9C35",  # AG (Australian Greens - Green)
#              "#DE3533",  # ALP (Australian Labor Party - Red)
#              "#00008B",  # C (Conservative - Dark Blue)
#              "#CC0000",  # CLP (Country Liberal Party - Red)
#              "#FFCC00",  # FFP (Family First Party - Yellow)
#              "#800000",  # Katter's Australian Party - Maroon
#              "#034694",  # LNPQ (Liberal National Party of Queensland - Blue)
#              "#0047AB",  # LPA (Liberal Party of Australia - Blue)
#              "#FF6600",  # ONP (One Nation Party - Orange)
#              "#7E4798",  # Reason Party - Purple
#              "#FFD700"   # United Australia Party - Gold
#   )
# )


color_dat <- distinct(color_dat, party, .keep_all = TRUE) %>% drop_na()


fin <- (as.Date(election_dat30$ds[1])-lubridate::days(1))
begin7 <- fin-lubridate::days(6)
begin30 <- fin-lubridate::days(29)

tibble(fin,
       begin7,
       begin30) %>%
  write_csv(here::here("dates.csv"))



# Function to create Dutch date strings with suffixes
create_date <- function(x) {
  the_date <- format(x, "%e %b") # %e for day of the month without leading zeros, %B for full month name in Dutch
  # In Dutch, date suffixes are not commonly used so we can omit the 'append_date_suffix' part
  return(trimws(the_date)) # trimws to remove any leading or trailing whitespace which might be left after %e
}

last7days_string <- paste0(create_date(begin7), " - ", create_date(fin), " ", lubridate::year(fin))
last30days_string <- paste0(create_date(begin30), " - ", create_date(fin), " ", lubridate::year(fin))

write_lines(last7days_string, "last7days_string.txt")
write_lines(last30days_string, "last30days_string.txt")


# election_dat30 %>% count(party)
#   arrange(left_right) %>% View()

# most_left_party <- color_dat$party[1]
most_left_party <- "The Green Party"
# # Print the Dutch date range strings
# print(last7days_string)
# print(last30days_string)
#
# # Reset locale back to the original if necessary
# Sys.setlocale("LC_TIME", "C")
# print("oo")

color_dat <- color_dat %>% 
  mutate(colors = case_when(
    colors == "#aaa" ~ "#A9A9A9",
    colors == "orange" ~ "#f77604",
    colors == "green" ~ "#7aba2d",
    colors == "lightgreen" ~ "#90EE90",
    colors == "darkgray" ~ "#A9A9A9",
    colors == "darkblue" ~ "#000080",
    colors == "black" ~ "#000000",
    colors == "lightblue" ~ "#ADD8E6",
    colors == "#ccc" ~ "#cccccc",
    is.na(colors) ~ "#00BFFF",
    T ~ colors
  ))