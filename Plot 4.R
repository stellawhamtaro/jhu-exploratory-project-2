#load souce classification files
ssc_file <- "Source_Classification_Code.rds"
data_ssc <- readRDS(ssc_file)
#select coal combustion related sources
data_coal <- data_ssc[grepl("Comb.*Coal", data_ssc$EI.Sector), ]
#calculations for total combustion related emissions
coal_scc <- unique(data_coal$SCC)
coal_emi <- data[(data$SCC %in% coal_scc), ]
coal_year <- coal_emi %>% group_by(year) %>% summarise(total = sum(Emissions))
#histogram
ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
  geom_bar(stat = "identity", fill = "darkred") + 
  ggtitle("Total coal combustion related PM2.5 Emissions") + 
  xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))
