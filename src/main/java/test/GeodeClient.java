package test;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.IntStream;

import org.apache.geode.cache.Region;
import org.apache.geode.cache.client.ClientCache;
import org.apache.geode.cache.client.ClientCacheFactory;
import org.apache.geode.cache.client.ClientRegionShortcut;

public class GeodeClient {

  private static final String LOCATOR = "geode-vm-0.c.data-g2c.internal";

  private static final int LOCATOR_PORT = 10334;

  private static final String REGION_NAME = "testRegion";

  private static final long numEntries = 2_000_000_000;

  private static final int numThreads = 20;

  private void populateRegion(Region region) throws InterruptedException {
    ExecutorService executorService = Executors.newFixedThreadPool(numThreads);
    long batchSize = numEntries / numThreads;
    IntStream.range(0, numThreads).forEach(threadId -> {
      long lowerBound = threadId * batchSize;
      long upperBound = (threadId + 1) * batchSize;
      executorService.submit(new Worker(threadId, region, lowerBound, upperBound));
    });
    executorService.shutdown();
    boolean terminated =  executorService.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
    if (!terminated) {
      System.out.println("Warning: the timeout elapsed before termination.");
    }
  }

  private void doTest() throws InterruptedException {
    ClientCacheFactory clientCacheFactory = new ClientCacheFactory();
    ClientCache clientCache = clientCacheFactory.addPoolLocator(LOCATOR, LOCATOR_PORT).create();
    Region clientRegion = clientCache.createClientRegionFactory(ClientRegionShortcut.PROXY).create(REGION_NAME);
    populateRegion(clientRegion);
  }

  public static void main(String args[]) throws InterruptedException {
    GeodeClient geodeClient = new GeodeClient();
    geodeClient.doTest();
  }
}
