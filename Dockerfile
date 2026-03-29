FROM maven:3.8.7-eclipse-temurin-11

RUN apt-get update && apt-get install -y \
    git \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g newman newman-reporter-allure

WORKDIR /app

RUN git clone https://github.com/arcralch/mvn-newman-allure.git .

CMD ["mvn", "clean", "test"]