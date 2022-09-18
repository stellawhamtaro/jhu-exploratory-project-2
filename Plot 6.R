#motor emissions in baltimore city and LA county
balti_la_year <- motor_emi %>% filter(fips == "24510" | fips == "06037") %>% 
  group_by(fips, year) %>% summarise(total = sum(Emissions))
#add key for location
balti_la_year <- mutate(balti_la_year, Unit = ifelse(fips == "24510", "Baltimore City", ifelse(fips == "06037", "Los Angeles County")))
#Histogram for emissions in baltimore and LA County
ggplot(balti_la_year, aes(factor(year), total, 
                          fill = Unit, label = round(total))) + 
  geom_bar(stat = "identity") + facet_grid(. ~ Unit) + 
  ggtitle("Total Motor Vehicle Emissions") +
  xlab("Year") + ylab("Pm2.5 Emissions in Tons") +
  theme(plot.title = element_text(hjust = 0.5)) + ylim(c(0, 8000)) +
  theme_classic() + geom_text(size = 4, vjust = -1)
